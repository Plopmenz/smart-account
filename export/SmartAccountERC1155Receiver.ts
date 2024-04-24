export const SmartAccountERC1155ReceiverContract = {
  address: "0xb757F77ca6c64562D0C73B6b3635825ca80A89A8",
  abi: [
    {
      type: "function",
      name: "onERC1155BatchReceived",
      inputs: [
        { name: "", type: "address", internalType: "address" },
        { name: "", type: "address", internalType: "address" },
        { name: "", type: "uint256[]", internalType: "uint256[]" },
        { name: "", type: "uint256[]", internalType: "uint256[]" },
        { name: "", type: "bytes", internalType: "bytes" },
      ],
      outputs: [{ name: "", type: "bytes4", internalType: "bytes4" }],
      stateMutability: "nonpayable",
    },
    {
      type: "function",
      name: "onERC1155Received",
      inputs: [
        { name: "", type: "address", internalType: "address" },
        { name: "", type: "address", internalType: "address" },
        { name: "", type: "uint256", internalType: "uint256" },
        { name: "", type: "uint256", internalType: "uint256" },
        { name: "", type: "bytes", internalType: "bytes" },
      ],
      outputs: [{ name: "", type: "bytes4", internalType: "bytes4" }],
      stateMutability: "nonpayable",
    },
  ],
} as const;
