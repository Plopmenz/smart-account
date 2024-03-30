import { Address, DeployInfo, Deployer } from "../../web3webdeploy/types";

export interface DeploySmartAccountModulesSettings
  extends Omit<DeployInfo, "contract" | "args"> {}

export async function deploySmartAccountModules(
  deployer: Deployer,
  settings: DeploySmartAccountModulesSettings
): Promise<Address> {
  return await deployer
    .deploy({
      id: "SmartAccountModules",
      contract: "SmartAccountModules",
      ...settings,
    })
    .then((deployment) => deployment.address);
}
