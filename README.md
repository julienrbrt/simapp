# `simapp.zone`

`SimApp.zone` is a set of live raw `SimApp` instances from the Cosmos SDK.
It provides instances that can be used for testing and development purposes.

## Use

| Name  (binary) | Endpoint / Faucet                                    | RPC (port) | GRPC (port) | REST (port) |
| -------------- | ---------------------------------------------------- | ---------- | ----------- | ----------- |
| `simapp-next`  | [https://next.simapp.zone](https://next.simapp.zone) | 26657      | 9090/9091   | 1317        |
| `simapp-v047`  | [https://v047.simapp.zone](https://v047.simapp.zone) | 26657      | 9090/9091   | 1317        |

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

- [Cosmos-SDK Documentation](https://docs.cosmos.network/)
- [API Reference](https://next.simapp.zone:1317/swagger/)
