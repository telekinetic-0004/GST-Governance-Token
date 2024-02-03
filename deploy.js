const { ethers } = require("hardhat");

async function main() {
    console.log("Starting deployment...");

    // Get the signers to identify the deploying address
    const [deployer] = await ethers.getSigners();
    console.log("Deploying contract with the account:", deployer.address);

    // Measure the start time
    const startTime = new Date();

    // Deploy the contract using the contract factory
    console.log("Deployment in process, please wait...");

    // Make sure to use the correct contract name (should match your contract file name)
    const GST = await ethers.getContractFactory("GST");

    // Pass the necessary constructor arguments if required
    const girlScriptToken = await GST.deploy(
        deployer.address, // defaultAdmin
        deployer.address, // pauser
        deployer.address  // minter
    );

    // Measure the end time and calculate the duration
    const endTime = new Date();
    const deploymentTime = (endTime - startTime) / 1000; // Convert milliseconds to seconds

    console.log("Library deployed to:", girlScriptToken.target);
    console.log(`Deployment completed in ${deploymentTime} seconds.`);
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});
