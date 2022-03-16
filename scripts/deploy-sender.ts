import { ethers } from "hardhat";

async function main() {
  const AMBSender = await ethers.getContractFactory("AMBSender");
  const ambSender = await AMBSender.deploy(
    "0xD4075FB57fCf038bFc702c915Ef9592534bED5c1",
    "0x20d35ea7c5186879E7d5Ec6d0941d451bBa54F4b",
    3000
  );

  await ambSender.deployed();

  console.log("AMBSender deployed to:", ambSender.address); // 0x3Dfe8C165929f4AbB02ffb3a46ccE6BdA4e5fABE
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
