import { Address, Deployer } from "../web3webdeploy/types";
import {
  DeploySmartAccountERC165Settings,
  deploySmartAccountERC165,
} from "./internal/SmartAccountERC165";

import {
  DeploySmartAccountModulesSettings,
  deploySmartAccountModules,
} from "./internal/SmartAccountModules";
import {
  DeploySmartAccountOwnableSettings,
  deploySmartAccountOwnable,
} from "./internal/SmartAccountOwnable";
import {
  DeploySmartAccountSetupSettings,
  deploySmartAccountSetup,
} from "./internal/SmartAccountSetup";

export interface SmartAccountDeploymentSettings {
  modulesSettings: DeploySmartAccountModulesSettings;
  setupSettings: Omit<
    DeploySmartAccountSetupSettings,
    "modules" | "ownable" | "erc165" | "multicall"
  >;

  ownableSettings: DeploySmartAccountOwnableSettings;
  erc165Settings: DeploySmartAccountERC165Settings;

  forceRedeploy?: boolean;
}

export interface SmartAccountDeployment {
  smartAccountModules: Address;
  smartAccountSetup: Address;
  modules: {
    ownable: Address;
    erc165: Address;
  };
}

export async function deploy(
  deployer: Deployer,
  settings?: SmartAccountDeploymentSettings
): Promise<SmartAccountDeployment> {
  if (settings?.forceRedeploy !== undefined && !settings.forceRedeploy) {
    const existingDeployment = await deployer.loadDeployment({
      deploymentName: "latest.json",
    });
    if (existingDeployment !== undefined) {
      return existingDeployment;
    }
  }

  const smartAccountModules = await deploySmartAccountModules(
    deployer,
    settings?.modulesSettings ?? {}
  );

  const ownable = await deploySmartAccountOwnable(
    deployer,
    settings?.ownableSettings ?? {}
  );
  const erc165 = await deploySmartAccountERC165(
    deployer,
    settings?.erc165Settings ?? {}
  );

  const smartAccountSetup = await deploySmartAccountSetup(deployer, {
    modules: smartAccountModules,
    ownable: ownable,
    erc165: erc165,
    ...(settings?.setupSettings ?? {}),
  });

  const deployment = {
    smartAccountModules: smartAccountModules,
    smartAccountSetup: smartAccountSetup,
    modules: {
      ownable: ownable,
      erc165: erc165,
    },
  };
  await deployer.saveDeployment({
    deploymentName: "latest.json",
    deployment: deployment,
  });
  return deployment;
}
