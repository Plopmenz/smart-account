export const SmartAccountERC165Contract = {
  address: "0xCa9FE66b1b6903c41e1A61eE20582bf48137765E",
  abi: [
    {
      type: "function",
      name: "supportsInterface",
      inputs: [{ name: "interfaceId", type: "bytes4", internalType: "bytes4" }],
      outputs: [{ name: "", type: "bool", internalType: "bool" }],
      stateMutability: "view",
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
  ],
} as const;
