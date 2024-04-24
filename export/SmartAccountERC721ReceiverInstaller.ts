export const SmartAccountERC721ReceiverInstallerContract = {
  address: "0x03d38803e07e0A2Fa5F934B352A281Ebc9027D42",
  abi: [
    {
      type: "constructor",
      inputs: [
        {
          name: "smartAccountERC721Receiver",
          type: "address",
          internalType: "contract ISmartAccountERC721Receiver",
        },
      ],
      stateMutability: "nonpayable",
    },
    {
      type: "function",
      name: "SMART_ACCOUNT_ERC721_RECEIVER",
      inputs: [],
      outputs: [
        {
          name: "",
          type: "address",
          internalType: "contract ISmartAccountERC721Receiver",
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
