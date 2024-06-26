export const SmartAccountOwnableContract = {
  address: "0x2F3Cec4e1ACF883adD5A426c56789242612c2F39",
  abi: [
    {
      type: "function",
      name: "owner",
      inputs: [],
      outputs: [{ name: "", type: "address", internalType: "address" }],
      stateMutability: "view",
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
