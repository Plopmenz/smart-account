import { Address, DeployInfo, Deployer } from "../../web3webdeploy/types";

export interface DeploySmartAccountSetupSettings
  extends Omit<DeployInfo, "contract" | "args"> {
  modules: Address;
  ownable: Address;
  erc165: Address;
}

export async function deploySmartAccountSetup(
  deployer: Deployer,
  settings: DeploySmartAccountSetupSettings
): Promise<Address> {
  return await deployer
    .deploy({
      id: "SmartAccountSetup",
      contract: "SmartAccountSetup",
      args: [settings.modules, settings.ownable, settings.erc165],
      ...settings,
    })
    .then((deployment) => deployment.address);
}
