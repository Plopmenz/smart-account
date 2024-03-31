export const SmartAccountContract = {
  abi: [
    {
      type: "function",
      name: "multicall",
      inputs: [{ name: "data", type: "bytes[]", internalType: "bytes[]" }],
      outputs: [{ name: "results", type: "bytes[]", internalType: "bytes[]" }],
      stateMutability: "nonpayable",
    },
    {
      type: "function",
      name: "performCall",
      inputs: [
        { name: "to", type: "address", internalType: "address" },
        { name: "value", type: "uint256", internalType: "uint256" },
        { name: "data", type: "bytes", internalType: "bytes" },
      ],
      outputs: [{ name: "returnValue", type: "bytes", internalType: "bytes" }],
      stateMutability: "nonpayable",
    },
    {
      type: "function",
      name: "performDelegateCall",
      inputs: [
        { name: "to", type: "address", internalType: "address" },
        { name: "data", type: "bytes", internalType: "bytes" },
      ],
      outputs: [{ name: "returnValue", type: "bytes", internalType: "bytes" }],
      stateMutability: "nonpayable",
    },
  ],
} as const;
