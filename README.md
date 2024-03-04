# Blockchain Voting Mechanism

This project aims to build and deploy a fully functioning, decentralized, secure and privacy rich voting mechanism on the ethereum blockchain.

Current tests are being run on the Hardhat Local Testnet. Future tests will be run on the Sepolia Testnet.

Next.js is used for the frontend whereas the backend is handled by hardhat.

To run the environment:

```shell
npm install
npx hardhat node
```

To run a local blockchain, provided with Hardhat Support.

Then in a new terminal:

```shell
npx hardhat run scripts/deploy.js --network localhost
```

To deploy the contract on the hardhat blockchain on a local network. Then to run the server:

```shell
npm run dev
```

Try running some of the extra following tasks:

```shell
npx hardhat help
npx hardhat test
GAS_REPORT=true npx hardhat test
npx hardhat node
npx hardhat run scripts/deploy.js
```
