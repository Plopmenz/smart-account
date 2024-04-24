import { Address, DeployInfo, Deployer } from "../../web3webdeploy/types";

export interface DeploySmartAccountERC1155ReceiverSettings
  extends Omit<DeployInfo, "contract" | "args"> {}

export async function deploySmartAccountERC1155Receiver(
  deployer: Deployer,
  settings: DeploySmartAccountERC1155ReceiverSettings
): Promise<Address> {
  return await deployer
    .deploy({
      id: "SmartAccountERC1155Receiver",
      contract: "SmartAccountERC1155Receiver",
      ...settings,
    })
    .then((deployment) => deployment.address);
}
