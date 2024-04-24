import { Address, DeployInfo, Deployer } from "../../web3webdeploy/types";

export interface DeploySmartAccountERC1155ReceiverInstallerSettings
  extends Omit<DeployInfo, "contract" | "args"> {
  erc1155Receiver: Address;
}

export async function deploySmartAccountERC1155ReceiverInstaller(
  deployer: Deployer,
  settings: DeploySmartAccountERC1155ReceiverInstallerSettings
): Promise<Address> {
  return await deployer
    .deploy({
      id: "SmartAccountERC1155ReceiverInstaller",
      contract: "SmartAccountERC1155ReceiverInstaller",
      args: [settings.erc1155Receiver],
      ...settings,
    })
    .then((deployment) => deployment.address);
}
