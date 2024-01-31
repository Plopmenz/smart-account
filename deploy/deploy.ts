import { Address, Deployer } from "../web3webdeploy/types";

export interface OpenmeshAdminDeploymentSettings {}

export interface OpenmeshAdminDeployment {
  admin: Address;
}

export async function deploy(
  deployer: Deployer,
  settings?: OpenmeshAdminDeploymentSettings
): Promise<OpenmeshAdminDeployment> {
  const admin = await deployer.deploy({
    id: "OpenmeshAdmin",
    contract: "AdminAccount",
    args: ["0x519ce4C129a981B2CBB4C3990B1391dA24E8EbF3"],
  });

  return {
    admin: admin,
  };
}
