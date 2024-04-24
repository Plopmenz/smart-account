import { Address, DeployInfo, Deployer } from "../../web3webdeploy/types";

export interface DeploySmartAccountERC721ReceiverInstallerSettings
  extends Omit<DeployInfo, "contract" | "args"> {
  erc721Receiver: Address;
}

export async function deploySmartAccountERC721ReceiverInstaller(
  deployer: Deployer,
  settings: DeploySmartAccountERC721ReceiverInstallerSettings
): Promise<Address> {
  return await deployer
    .deploy({
      id: "SmartAccountERC721ReceiverInstaller",
      contract: "SmartAccountERC721ReceiverInstaller",
      args: [settings.erc721Receiver],
      ...settings,
    })
    .then((deployment) => deployment.address);
}
