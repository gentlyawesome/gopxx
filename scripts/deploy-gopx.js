const hre = require("hardhat");

async function main() {

  const GOPXX = await hre.ethers.getContractFactory("GOPXX");
  console.log('Deploying GOPXX...');
  const token = await GOPXX.deploy('10000000000000000000000');

  await token.deployed();
  console.log("GOPXX deployed to:", token.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });