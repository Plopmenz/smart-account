import { Address, DeployInfo, Deployer } from "../../web3webdeploy/types";

export interface DeploySmartAccountSettings
  extends Omit<DeployInfo, "contract" | "args"> {
  baseInstaller: Address;
  owner: Address;
}

export async function deploySmartAccount(
  deployer: Deployer,
  settings: DeploySmartAccountSettings
): Promise<Address> {
  const installerAbi = await deployer.getAbi("SmartAccountBaseInstaller");
  return await deployer
    .deploy({
      contract: "SmartAccount",
      args: [
        settings.baseInstaller,
        deployer.viem.encodeFunctionData({
          abi: installerAbi,
          functionName: "install",
          args: [settings.owner],
        }),
      ],
      ...settings,
    })
    .then((deployment) => deployment.address);
}
