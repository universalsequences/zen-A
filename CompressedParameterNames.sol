
pragma solidity ^0.8.20;
import "./InflateLib.sol";

contract CompressedParameterNames {
    bytes public data;

    constructor() {
        data = hex"4d8f4b72c32010442f9405e6cf05b2cc15baf80c1209128a4ce4d2ed83bcb197eff54c57f50626ad0d846fff537050c552d68f0d2c04272482bfd3e74ebf7fb4c673e89b533665b4d8fd411767a39242a2ea4f3ca80fc593f082e37eae7de6d84742a3e419c82c2cf6d67d277c5d263b6f032aad539f072b6e8c0c980b66df71b43a9c764127fdba314e9061ef2d5631211c72405e067aa68dcae87b99f028e9f914b215322156bf2195639828a31137745ab6867d540d971d67518f162c2d5d4c2a718da9b6e02b683dae35d7987f";
    }

    function uncompress()
        external
        view
        returns (string memory)
    {
        (InflateLib.ErrorCode err, bytes memory mem) = InflateLib.puff(data, 309);

        if (err == InflateLib.ErrorCode.ERR_NONE) {
            return string(mem);
        }
        return "";
    }
}
