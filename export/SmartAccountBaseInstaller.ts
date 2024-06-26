export const SmartAccountBaseInstallerContract = {
  address: "0x4811864B715C0F1B0f9790a8ee6F11dC25b7F258",
  abi: [
    {
      type: "constructor",
      inputs: [
        {
          name: "smartAccountModules",
          type: "address",
          internalType: "contract ISmartAccountModules",
        },
        {
          name: "smartAccountOwnable",
          type: "address",
          internalType: "contract ISmartAccountOwnable",
        },
        {
          name: "smartAccountERC165",
          type: "address",
          internalType: "contract ISmartAccountERC165",
        },
      ],
      stateMutability: "nonpayable",
    },
    {
      type: "function",
      name: "SMART_ACCOUNT_ERC165",
      inputs: [],
      outputs: [
        {
          name: "",
          type: "address",
          internalType: "contract ISmartAccountERC165",
        },
      ],
      stateMutability: "view",
    },
    {
      type: "function",
      name: "SMART_ACCOUNT_MODULES",
      inputs: [],
      outputs: [
        {
          name: "",
          type: "address",
          internalType: "contract ISmartAccountModules",
        },
      ],
      stateMutability: "view",
    },
    {
      type: "function",
      name: "SMART_ACCOUNT_OWNABLE",
      inputs: [],
      outputs: [
        {
          name: "",
          type: "address",
          internalType: "contract ISmartAccountOwnable",
        },
      ],
      stateMutability: "view",
    },
    {
      type: "function",
      name: "install",
      inputs: [{ name: "owner", type: "address", internalType: "address" }],
      outputs: [],
      stateMutability: "nonpayable",
    },
    {
      type: "function",
      name: "setModule",
      inputs: [
        { name: "functionSelector", type: "bytes4", internalType: "bytes4" },
        { name: "module", type: "address", internalType: "address" },
      ],
      outputs: [],
      stateMutability: "nonpayable",
    },
    {
      type: "function",
      name: "transferOwnership",
      inputs: [{ name: "newOwner", type: "address", internalType: "address" }],
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
    {
      type: "event",
      name: "NewOwner",
      inputs: [
        {
          name: "account",
          type: "address",
          indexed: false,
          internalType: "address",
        },
      ],
      anonymous: false,
    },
    {
      type: "error",
      name: "NotOwner",
      inputs: [
        { name: "account", type: "address", internalType: "address" },
        { name: "owner", type: "address", internalType: "address" },
      ],
    },
  ],
} as const;
