import { Address, Deployer } from "../web3webdeploy/types";

export interface OpenmeshAdminDeploymentSettings {}

export interface OpenmeshAdminDeployment {}

export async function deploy(
  deployer: Deployer,
  settings?: OpenmeshAdminDeploymentSettings
): Promise<OpenmeshAdminDeployment> {
  return {};
}
