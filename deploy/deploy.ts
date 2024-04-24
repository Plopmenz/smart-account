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
import {
  DeploySmartAccountERC721ReceiverSettings,
  deploySmartAccountERC721Receiver,
} from "./internal/SmartAccountERC721Receiver";
import {
  DeploySmartAccountERC1155ReceiverSettings,
  deploySmartAccountERC1155Receiver,
} from "./internal/SmartAccountERC1155Receiver";
import {
  DeploySmartAccountERC721ReceiverInstallerSettings,
  deploySmartAccountERC721ReceiverInstaller,
} from "./internal/SmartAccountERC721ReceiverInstaller";
import {
  DeploySmartAccountERC1155ReceiverInstallerSettings,
  deploySmartAccountERC1155ReceiverInstaller,
} from "./internal/SmartAccountERC1155ReceiverInstaller";

export interface SmartAccountDeploymentSettings {
  modulesSettings: DeploySmartAccountModulesSettings;
  baseInstallerSettings: Omit<
    DeploySmartAccountBaseInstallerSettings,
    "modules" | "ownable" | "erc165"
  >;
  erc721ReceiverInstallerSettings: Omit<
    DeploySmartAccountERC721ReceiverInstallerSettings,
    "erc721Receiver"
  >;
  erc1155ReceiverInstallerSettings: Omit<
    DeploySmartAccountERC1155ReceiverInstallerSettings,
    "erc1155Receiver"
  >;

  ownableSettings: DeploySmartAccountOwnableSettings;
  erc165Settings: DeploySmartAccountERC165Settings;
  trustlessExecutionSettings: DeploySmartAccountTrustlessExecutionSettings;
  erc721ReceiverSettings: DeploySmartAccountERC721ReceiverSettings;
  erc1155ReceiverSettings: DeploySmartAccountERC1155ReceiverSettings;

  forceRedeploy?: boolean;
}

export interface SmartAccountDeployment {
  smartAccountModules: Address;
  installers: {
    smartAccountBase: Address;
    erc721Receiver: Address;
    erc1155Receiver: Address;
  };
  modules: {
    ownable: Address;
    erc165: Address;
    trustlessExecution: Address;
    erc721Receiver: Address;
    erc1155Receiver: Address;
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

  // const smartAccountModules = await deploySmartAccountModules(
  //   deployer,
  //   settings?.modulesSettings ?? {}
  // );

  // const ownable = await deploySmartAccountOwnable(
  //   deployer,
  //   settings?.ownableSettings ?? {}
  // );
  // const erc165 = await deploySmartAccountERC165(
  //   deployer,
  //   settings?.erc165Settings ?? {}
  // );
  // const trustlessExecution = await deploySmartAccountTrustlessExecution(
  //   deployer,
  //   settings?.trustlessExecutionSettings ?? {}
  // );
  const erc721Receiver = await deploySmartAccountERC721Receiver(
    deployer,
    settings?.erc721ReceiverSettings ?? {}
  );
  const erc1155Receiver = await deploySmartAccountERC1155Receiver(
    deployer,
    settings?.erc1155ReceiverSettings ?? {}
  );

  // const smartAccountBaseInstaller = await deploySmartAccountBaseInstaller(
  //   deployer,
  //   {
  //     modules: smartAccountModules,
  //     ownable: ownable,
  //     erc165: erc165,
  //     ...(settings?.baseInstallerSettings ?? {}),
  //   }
  // );
  const erc721ReceiverInstaller =
    await deploySmartAccountERC721ReceiverInstaller(deployer, {
      erc721Receiver: erc721Receiver,
      ...(settings?.baseInstallerSettings ?? {}),
    });
  const erc1155ReceiverInstaller =
    await deploySmartAccountERC1155ReceiverInstaller(deployer, {
      erc1155Receiver: erc1155Receiver,
      ...(settings?.baseInstallerSettings ?? {}),
    });

  // Example deployment:
  // await deploySmartAccount(deployer, {
  //   id: "MySmartAccount",
  //   baseInstaller: smartAccountBaseInstaller,
  //   owner: deployer.settings.defaultFrom,
  // });

  // const deployment: SmartAccountDeployment = {
  //   smartAccountModules: smartAccountModules,
  //   installers: {
  //     smartAccountBase: smartAccountBaseInstaller,
  //     erc721Receiver: erc721ReceiverInstaller,
  //     erc1155Receiver: erc1155ReceiverInstaller,
  //   },
  //   modules: {
  //     ownable: ownable,
  //     erc165: erc165,
  //     trustlessExecution: trustlessExecution,
  //     erc721Receiver: erc721Receiver,
  //     erc1155Receiver: erc1155Receiver,
  //   },
  // };
  // await deployer.saveDeployment({
  //   deploymentName: "latest.json",
  //   deployment: deployment,
  // });
  // return deployment;
  return {
    smartAccountModules: "0xdF19f5Fcd5F8F1bd3C387422FC65109F5117F990",
    installers: {
      smartAccountBase: "0x4811864B715C0F1B0f9790a8ee6F11dC25b7F258",
      erc721Receiver: "0x03d38803e07e0A2Fa5F934B352A281Ebc9027D42",
      erc1155Receiver: "0x5769C66bBCF8963950C41ace86Bbd15B7D0Ec084",
    },
    modules: {
      ownable: "0x2F3Cec4e1ACF883adD5A426c56789242612c2F39",
      erc165: "0xCa9FE66b1b6903c41e1A61eE20582bf48137765E",
      trustlessExecution: "0x9478eaab9F531533487c220C451820c3c7901e6b",
      erc721Receiver: "0x4433B7Fcd9b90dACf14A54d55c3f6626C834f6E5",
      erc1155Receiver: "0xb757F77ca6c64562D0C73B6b3635825ca80A89A8",
    },
  };
}
