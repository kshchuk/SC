/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.19",
};

require("@nomicfoundation/hardhat-verify");

module.exports = {
  networks: {
    mainnet: {
        url: "https://sepolia.infura.io/v3/f393bf3868ca4747bbde606122d4ee9e",
    }
},

  etherscan: {
    // Your API key for Etherscan
    // Obtain one at https://etherscan.io/
    apiKey: "Y1BSTC5AU84NWJ28HNCCBZ4V3AEP66FZSZ"
  }
};