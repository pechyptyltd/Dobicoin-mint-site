const hre = require("hardhat");

async function main() {
  const DobieCoinNFT = await hre.ethers.getContractFactory("DobieCoinNFT");
  const contract = await DobieCoinNFT.deploy("ipfs://YOUR_PLACEHOLDER_URI/");
  await contract.deployed();
  console.log("DobieCoinNFT deployed to:", contract.address);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
