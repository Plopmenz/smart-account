export const SmartAccountERC721ReceiverContract = {
  address: "0x4433B7Fcd9b90dACf14A54d55c3f6626C834f6E5",
  abi: [
    {
      type: "function",
      name: "onERC721Received",
      inputs: [
        { name: "", type: "address", internalType: "address" },
        { name: "", type: "address", internalType: "address" },
        { name: "", type: "uint256", internalType: "uint256" },
        { name: "", type: "bytes", internalType: "bytes" },
      ],
      outputs: [{ name: "", type: "bytes4", internalType: "bytes4" }],
      stateMutability: "nonpayable",
    },
  ],
} as const;
