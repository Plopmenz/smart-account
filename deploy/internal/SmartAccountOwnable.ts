import { Address, DeployInfo, Deployer } from "../../web3webdeploy/types";

export interface DeploySmartAccountOwnableSettings
  extends Omit<DeployInfo, "contract" | "args"> {}

export async function deploySmartAccountOwnable(
  deployer: Deployer,
  settings: DeploySmartAccountOwnableSettings
): Promise<Address> {
  return await deployer
    .deploy({
      id: "SmartAccountOwnable",
      contract: "SmartAccountOwnable",
      ...settings,
    })
    .then((deployment) => deployment.address);
}
