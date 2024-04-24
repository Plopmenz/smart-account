import { Address, DeployInfo, Deployer } from "../../web3webdeploy/types";

export interface DeploySmartAccountERC721ReceiverSettings
  extends Omit<DeployInfo, "contract" | "args"> {}

export async function deploySmartAccountERC721Receiver(
  deployer: Deployer,
  settings: DeploySmartAccountERC721ReceiverSettings
): Promise<Address> {
  return await deployer
    .deploy({
      id: "SmartAccountERC721Receiver",
      contract: "SmartAccountERC721Receiver",
      ...settings,
    })
    .then((deployment) => deployment.address);
}
