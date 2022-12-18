import express from "express";
import * as path from "path";

import { DirectSecp256k1HdWallet } from "@cosmjs/proto-signing";
import { SigningStargateClient } from "@cosmjs/stargate";
import { FrequencyChecker } from "./checker";

import conf from "./config";

// load config
console.log("loaded config: ", conf);

const app = express();

const checker = new FrequencyChecker(conf);

app.get("/", (req, res) => {
  res.sendFile(path.resolve("./index.html"));
});

app.get("/config.json", async (req, res) => {
  const wallet = await DirectSecp256k1HdWallet.fromMnemonic(
    conf.sender.mnemonic,
    conf.sender.option
  );
  const [firstAccount] = await wallet.getAccounts();
  res.send({
    version: conf.blockchain.version,
    sample: firstAccount.address,
  });
});

app.get("/send/:address", async (req, res) => {
  const { address } = req.params;
  console.log("request tokens to ", address, req.ip);
  if (address) {
    try {
      if (address.startsWith(conf.sender.option.prefix)) {
        if (
          (await checker.checkAddress(address)) &&
          (await checker.checkIp(req.ip))
        ) {
          checker.update(req.ip); // get ::1 on localhost
          sendTx(address).then((ret) => {
            console.log("sent tokens to ", address);
            checker.update(address);
            res.send({ result: ret });
          });
        } else {
          res.send({ result: "Too many requests." });
        }
      } else {
        res.send({ result: `Address [${address}] is not supported.` });
      }
    } catch (err) {
      console.error(err);
      res.send({ result: "Failed, Please contact admin." });
    }
  } else {
    // send result
    res.send({ result: "address is required" });
  }
});

app.listen(conf.port, () => {
  console.log(`Faucet app listening on port ${conf.port}`);
});

async function sendTx(recipient) {
  const wallet = await DirectSecp256k1HdWallet.fromMnemonic(
    conf.sender.mnemonic,
    conf.sender.option
  );
  const [firstAccount] = await wallet.getAccounts();

  const rpcEndpoint = conf.blockchain.rpc_endpoint;
  const client = await SigningStargateClient.connectWithSigner(
    rpcEndpoint,
    wallet
  );

  const amount = conf.tx.amount;
  const fee = conf.tx.fee;

  return client.sendTokens(firstAccount.address, recipient, [amount], fee);
}
