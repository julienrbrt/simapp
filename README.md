# `simapp.zone`

## Use

| Name  (binary) | Endpoint                                             | Faucet | RPC (port) | GRPC (port) | REST (port) |
| -------------- | ---------------------------------------------------- | ------ | ---------- | ----------- | ----------- |
| `simapp-next`  | [https://next.simapp.zone](https://next.simapp.zone) | 80     | 26657      | 9090/9091   | 1317        |
| `simapp-v047`  | [https://v047.simapp.zone](https://v047.simapp.zone) | 80     | 26657      | 9090/9091   | 1317        |

## Details

| Name (binary) | Version               | Source                                                                   |
| ------------- | --------------------- | ------------------------------------------------------------------------ |
| `simapp-next` | `next` (a.k.a `main`) | [simapp@main](https://github.com/cosmos/cosmos-sdk/tree/main/simapp)     |
| `simapp-v047` | `v0.47`               | [simapp@v0.47](https://github.com/cosmos/cosmos-sdk/tree/v0.47.0/simapp) |

## Use locally

To replicate `simapp.zone` configuration, use the `make init` command, using the simapp version argument.

```sh
make init version={next|v047}
```

## Useful links

- [Cosmos-SDK Documentation](https://docs.cosmos.network/)
