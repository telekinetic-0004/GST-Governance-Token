# `GST-Governance-Token Smart Contract`

`This document provides an overview of the GST token, an ERC-20 Governance token with advanced features such as pausing, minting, voting, and rolebased access control.`


## `Run Locally`

`Clone the project`

```bash
  git clone https://github.com/telekinetic-0004/GST-Governance-Token
```

`Go to the project directory`

```bash
  cd my-project
```

`Install hardhat`

```bash
  npm install --save-dev hardhat@latest
  npm install @nomicfoundation/hardhat-toolbox
```

#### note: Kindly install all the `openzeppelin libraries` as required

#### Change the credential details in `config.json` before deploying and compiling

`Compile the smart contract`

```bash
  npx compile
```

## `Deployment`

```bash
  npx hardhat run deploy.js --network sepolia
```

