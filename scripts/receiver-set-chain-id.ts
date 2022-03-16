import { ethers } from "hardhat";

async function main() {
  const AMBReceiver = await ethers.getContractFactory("AMBReceiver");
  const ambReceiver = await AMBReceiver.attach(
    "0x20d35ea7c5186879E7d5Ec6d0941d451bBa54F4b"
  );

  await ambReceiver.setChainId(4, true);

  console.log("Chain ID set!");
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
