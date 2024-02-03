require('@nomicfoundation/hardhat-toolbox');
const fs = require('fs');

// Load the configuration from config.json
const configPath = 'config.json'; // Adjust the path if necessary
const rawConfig = fs.readFileSync(configPath);
const { SEPOLIAURL, PRIVKEY } = JSON.parse(rawConfig);

module.exports = {
  solidity: {
    version: "0.8.20",
    settings: {
      optimizer: {
        enabled: true,
        runs: 200,
      },
    },
    compilers: [
      {
        version: "0.8.20",
      },
    ],
  },
  paths: {
    sources: "./contracts", // Adjust the path to match your project structure
  },

  networks: {
    sepolia: {
      url: SEPOLIAURL,
      accounts: [PRIVKEY]
    },
  },
  contracts: ["./contracts/GST.sol"]
};
