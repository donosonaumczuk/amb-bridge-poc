import { ethers } from "hardhat";

async function main() {
  const AMBReceiver = await ethers.getContractFactory("AMBReceiver");
  const ambReceiver = await AMBReceiver.deploy(
    "0xc38D4991c951fE8BCE1a12bEef2046eF36b0FA4A",
    ethers.constants.AddressZero,
    4
  );

  await ambReceiver.deployed();

  console.log("AMBReceiver deployed to:", ambReceiver.address); // 0x20d35ea7c5186879E7d5Ec6d0941d451bBa54F4b
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
