import { Address, DeployInfo, Deployer } from "../../web3webdeploy/types";

export interface DeploySmartAccountTrustlessExecutionSettings
  extends Omit<DeployInfo, "contract" | "args"> {}

export async function deploySmartAccountTrustlessExecution(
  deployer: Deployer,
  settings: DeploySmartAccountTrustlessExecutionSettings
): Promise<Address> {
  return await deployer
    .deploy({
      id: "SmartAccountTrustlessExecution",
      contract: "SmartAccountTrustlessExecution",
      ...settings,
    })
    .then((deployment) => deployment.address);
}
