import { Address, DeployInfo, Deployer } from "../../web3webdeploy/types";

export interface DeploySmartAccountERC165Settings
  extends Omit<DeployInfo, "contract" | "args"> {}

export async function deploySmartAccountERC165(
  deployer: Deployer,
  settings: DeploySmartAccountERC165Settings
): Promise<Address> {
  return await deployer
    .deploy({
      id: "SmartAccountERC165",
      contract: "SmartAccountERC165",
      ...settings,
    })
    .then((deployment) => deployment.address);
}
