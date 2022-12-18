import { stringToPath } from "@cosmjs/crypto";

export default {
  port: process.env.FAUCET_PORT || 8080, // http port
  db: {
    path: "./db/faucet-" + process.env.FAUCET_VERSION + ".db", // save request states
  },
  blockchain: {
    version: process.env.FAUCET_VERSION || "",
    // make sure that CORS is enabled in rpc section in config.toml
    // cors_allowed_origins = ["*"]
    rpc_endpoint:
      "https://" +
      (process.env.FAUCET_VERSION || "next") +
      ".simapp.zone:26657",
  },
  sender: {
    mnemonic:
      process.env.FAUCET_MNEMONIC ||
      "surround miss nominee dream gap cross assault thank captain prosper drop duty group candy wealth weather scale put",
    option: {
      hdPaths: [stringToPath("m/44'/118'/0'/0/0")],
      prefix: "cosmos",
    },
  },
  tx: {
    amount: {
      denom: "stake",
      amount: "10000",
    },
    fee: {
      amount: [
        {
          amount: "1000",
          denom: "stake",
        },
      ],
      gas: "200000",
    },
  },
  limit: {
    // how many times each wallet address is allowed in a window(24h)
    address: 1,
    // how many times each ip is allowed in a window(24h),
    // if you use proxy, double check if the req.ip is return client's ip.
    ip: 10,
  },
};
