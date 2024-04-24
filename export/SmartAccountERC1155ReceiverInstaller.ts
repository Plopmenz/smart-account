export const SmartAccountERC1155ReceiverInstallerContract = {
  address: "0x5769C66bBCF8963950C41ace86Bbd15B7D0Ec084",
  abi: [
    {
      type: "constructor",
      inputs: [
        {
          name: "smartAccountERC1155Receiver",
          type: "address",
          internalType: "contract ISmartAccountERC1155Receiver",
        },
      ],
      stateMutability: "nonpayable",
    },
    {
      type: "function",
      name: "SMART_ACCOUNT_ERC1155_RECEIVER",
      inputs: [],
      outputs: [
        {
          name: "",
          type: "address",
          internalType: "contract ISmartAccountERC1155Receiver",
        },
      ],
      stateMutability: "view",
    },
    {
      type: "function",
      name: "install",
      inputs: [],
      outputs: [],
      stateMutability: "nonpayable",
    },
    {
      type: "function",
      name: "uninstall",
      inputs: [],
      outputs: [],
      stateMutability: "nonpayable",
    },
    {
      type: "event",
      name: "InterfaceSupportedChanged",
      inputs: [
        {
          name: "interfaceId",
          type: "bytes4",
          indexed: true,
          internalType: "bytes4",
        },
        {
          name: "supported",
          type: "bool",
          indexed: false,
          internalType: "bool",
        },
      ],
      anonymous: false,
    },
    {
      type: "event",
      name: "ModuleSet",
      inputs: [
        {
          name: "functionSelector",
          type: "bytes4",
          indexed: false,
          internalType: "bytes4",
        },
        {
          name: "module",
          type: "address",
          indexed: false,
          internalType: "address",
        },
      ],
      anonymous: false,
    },
  ],
} as const;
