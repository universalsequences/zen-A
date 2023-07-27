
pragma solidity ^0.8.20;
import "./InflateLib.sol";

contract CompressedParameterNames {
    bytes public data;

    constructor() {
        data = hex"4d904976c4200c442f9485cd60e00259e60af518443789a7d8d89dbe7d847b912ceb0b15a55ad1296b03e1d37f159c34622af3db8a2e04271582dfe97da3ef83e6f86c3846db5b2cb1fa9358f74edb94ffe96c74d24834fa271e54198924bd14d89f73bd0b6c3c2136bd062a4b8b6da9be123e1ac9cedb8091e65bbdb396da79e590275e5f8912232d8c5101f782bbaf389791d9a07ae9eceb823c35e0c290863f1fe32499eeff4f567752b273782d582f28a457c61d3d04b7f0c3dc511c28b7678295ef06a333ea566e78947459879e4810d2764cc83e11aef6828b561bccc7144add1bc856aa8438fa15a99c4ca2723d1f721b4ba24b46237b549ad6051bc76ccc799dfa76e431cd0d6427ba3870644c4b2b23934e62608f25f811349fadded6ee2f";
    }

    function uncompress()
        external
        view
        returns (string memory)
    {
        (InflateLib.ErrorCode err, bytes memory mem) = InflateLib.puff(data, 470);

        if (err == InflateLib.ErrorCode.ERR_NONE) {
            return string(mem);
        }
        return "";
    }
}
