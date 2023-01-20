# `simapp.zone`

`simapp.zone` is a set of live raw `SimApp` instances from the Cosmos SDK.
It provides instances that can be used for testing and development purposes.

## Use

| Endpoint / Faucet                                    | RPC (port) | gRPC (port) | gRPC-web (port) | gRPC-gateway (port) |
| ---------------------------------------------------- | ---------- | ----------- | --------------- | ------------------- |
| [https://next.simapp.zone](https://next.simapp.zone) | 26657      | 9090        | 1317            | 1317                |
| [https://v047.simapp.zone](https://v047.simapp.zone) | 26657      | 9090        | 9091            | 1317                |

An explorer is available at [`explorer.simapp.zone`](https://explorer.simapp.zone).

## Details

The nodes binary are updated daily to the latest commited version, but the state is *not* reset.

| Name (binary) | Version               | Source                                                                   |
| ------------- | --------------------- | ------------------------------------------------------------------------ |
| `simapp-next` | `next` (a.k.a `main`) | [simapp@main](https://github.com/cosmos/cosmos-sdk/tree/main/simapp)     |
| `simapp-v047` | `v0.47`               | [simapp@v0.47](https://github.com/cosmos/cosmos-sdk/tree/v0.47.0/simapp) |

## Use locally

To replicate `simapp.zone` configuration, use the `make init` command, using the simapp version argument.

```sh
make build version={next|v047}
make init version={next|v047}
```

## Useful links

- [Explorer](https://explorer.simapp.zone/)
- [API Reference](https://next.simapp.zone:1317/swagger/)
- [Cosmos SDK Documentation](https://docs.cosmos.network/)
