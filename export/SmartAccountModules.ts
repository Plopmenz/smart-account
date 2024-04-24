export const SmartAccountModulesContract = {
  address: "0xdF19f5Fcd5F8F1bd3C387422FC65109F5117F990",
  abi: [
    {
      type: "function",
      name: "getModule",
      inputs: [
        { name: "functionSelector", type: "bytes4", internalType: "bytes4" },
      ],
      outputs: [{ name: "module", type: "address", internalType: "address" }],
      stateMutability: "view",
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
      type: "error",
      name: "FunctionNotFound",
      inputs: [
        { name: "functionSelector", type: "bytes4", internalType: "bytes4" },
      ],
    },
  ],
} as const;
