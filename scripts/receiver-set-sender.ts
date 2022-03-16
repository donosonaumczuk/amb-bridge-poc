import { ethers } from "hardhat";

async function main() {
  const AMBReceiver = await ethers.getContractFactory("AMBReceiver");
  const ambReceiver = await AMBReceiver.attach(
    "0x20d35ea7c5186879E7d5Ec6d0941d451bBa54F4b"
  );

  await ambReceiver.setSender("0x3Dfe8C165929f4AbB02ffb3a46ccE6BdA4e5fABE");

  console.log("Sender set!");
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
