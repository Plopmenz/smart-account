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
  DeploySmartAccountBaseInstallerSettings,
  deploySmartAccountBaseInstaller,
} from "./internal/SmartAccountBaseInstaller";
import {
  DeploySmartAccountTrustlessExecutionSettings,
  deploySmartAccountTrustlessExecution,
} from "./internal/SmartAccountTrustlessExecution";

export interface SmartAccountDeploymentSettings {
  modulesSettings: DeploySmartAccountModulesSettings;
  setupSettings: Omit<
    DeploySmartAccountBaseInstallerSettings,
    "modules" | "ownable" | "erc165" | "multicall"
  >;

  ownableSettings: DeploySmartAccountOwnableSettings;
  erc165Settings: DeploySmartAccountERC165Settings;
  trustlessExecutionSettings: DeploySmartAccountTrustlessExecutionSettings;

  forceRedeploy?: boolean;
}

export interface SmartAccountDeployment {
  smartAccountModules: Address;
  smartAccountBaseInstaller: Address;
  modules: {
    ownable: Address;
    erc165: Address;
    trustlessExecution: Address;
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
  const trustlessExecution = await deploySmartAccountTrustlessExecution(
    deployer,
    settings?.trustlessExecutionSettings ?? {}
  );

  const smartAccountBaseInstaller = await deploySmartAccountBaseInstaller(
    deployer,
    {
      modules: smartAccountModules,
      ownable: ownable,
      erc165: erc165,
      ...(settings?.setupSettings ?? {}),
    }
  );

  // Example deployment:
  // await deploySmartAccount(deployer, {
  //   id: "MySmartAccount",
  //   baseInstaller: smartAccountBaseInstaller,
  //   owner: deployer.settings.defaultFrom,
  // });

  const deployment = {
    smartAccountModules: smartAccountModules,
    smartAccountBaseInstaller: smartAccountBaseInstaller,
    modules: {
      ownable: ownable,
      erc165: erc165,
      trustlessExecution: trustlessExecution,
    },
  };
  await deployer.saveDeployment({
    deploymentName: "latest.json",
    deployment: deployment,
  });
  return deployment;
}
