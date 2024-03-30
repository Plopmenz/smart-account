import { Address, DeployInfo, Deployer } from "../../web3webdeploy/types";

export interface DeploySmartAccountBaseInstallerSettings
  extends Omit<DeployInfo, "contract" | "args"> {
  modules: Address;
  ownable: Address;
  erc165: Address;
}

export async function deploySmartAccountBaseInstaller(
  deployer: Deployer,
  settings: DeploySmartAccountBaseInstallerSettings
): Promise<Address> {
  return await deployer
    .deploy({
      id: "SmartAccountBaseInstaller",
      contract: "SmartAccountBaseInstaller",
      args: [settings.modules, settings.ownable, settings.erc165],
      ...settings,
    })
    .then((deployment) => deployment.address);
}
