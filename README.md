# Pre-requisite

1. get api @ alchemyapi.io
2. setup private key with Ropsten

# Setup

```shell
npm i
```

```shell
npx hardhat accounts
npx hardhat compile
npx hardhat clean
npx hardhat test
npx hardhat node
node scripts/sample-script.js
npx hardhat help
```

# Deploy

```shell
npx hardhat run --network ropsten scripts/deploy-gopx.js
```
