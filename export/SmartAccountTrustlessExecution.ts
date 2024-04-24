export const SmartAccountTrustlessExecutionContract = {
  address: "0x9478eaab9F531533487c220C451820c3c7901e6b",
  abi: [
    {
      type: "function",
      name: "execute",
      inputs: [
        { name: "_callId", type: "bytes32", internalType: "bytes32" },
        {
          name: "_actions",
          type: "tuple[]",
          internalType: "struct ISmartAccountTrustlessExecution.Action[]",
          components: [
            { name: "to", type: "address", internalType: "address" },
            { name: "value", type: "uint256", internalType: "uint256" },
            { name: "data", type: "bytes", internalType: "bytes" },
          ],
        },
        { name: "_allowFailureMap", type: "uint256", internalType: "uint256" },
      ],
      outputs: [
        { name: "execResults", type: "bytes[]", internalType: "bytes[]" },
        { name: "failureMap", type: "uint256", internalType: "uint256" },
      ],
      stateMutability: "nonpayable",
    },
    {
      type: "event",
      name: "ExecutePermissionSet",
      inputs: [
        {
          name: "account",
          type: "address",
          indexed: false,
          internalType: "address",
        },
        { name: "allowed", type: "bool", indexed: false, internalType: "bool" },
      ],
      anonymous: false,
    },
    {
      type: "event",
      name: "Executed",
      inputs: [
        {
          name: "actor",
          type: "address",
          indexed: true,
          internalType: "address",
        },
        {
          name: "callId",
          type: "bytes32",
          indexed: false,
          internalType: "bytes32",
        },
        {
          name: "actions",
          type: "tuple[]",
          indexed: false,
          internalType: "struct ISmartAccountTrustlessExecution.Action[]",
          components: [
            { name: "to", type: "address", internalType: "address" },
            { name: "value", type: "uint256", internalType: "uint256" },
            { name: "data", type: "bytes", internalType: "bytes" },
          ],
        },
        {
          name: "allowFailureMap",
          type: "uint256",
          indexed: false,
          internalType: "uint256",
        },
        {
          name: "failureMap",
          type: "uint256",
          indexed: false,
          internalType: "uint256",
        },
        {
          name: "execResults",
          type: "bytes[]",
          indexed: false,
          internalType: "bytes[]",
        },
      ],
      anonymous: false,
    },
    {
      type: "error",
      name: "ActionFailed",
      inputs: [{ name: "index", type: "uint256", internalType: "uint256" }],
    },
    { type: "error", name: "InsufficientGas", inputs: [] },
    {
      type: "error",
      name: "NoExecutePermission",
      inputs: [{ name: "account", type: "address", internalType: "address" }],
    },
    { type: "error", name: "TooManyActions", inputs: [] },
  ],
} as const;
