
pragma solidity ^0.8.20;
import "./InflateLib.sol";

contract CompressedParameterValues {
    bytes public data;

    constructor() {
        data = hex"85920b8a043108442fe488ff18f6fef7da323d3f666097060989faacb2852b16a90909dd948475359967f296a224a79be15674a28721954e9a2562eb425ce988519bccbcd97d51a050374be38e5d638a752ac49b7634a7da0fbaa451e1713e5e059c447076a3fc41c618430eeafb45ee439e6e6bcd39bd48b3bd30431cb4a3626102de662f34c654cd04b7255f5c15a36dc1bbed5b709016d99be00b1b470a50d25a6cf02c90f581b53d4e592955c2851ac5e3b6c571dbfe75db07ae5f70bdbb9db9ed3a8d6a7548707ffa6db5ee7e2fdbbcccffd26d68f08936baf949d30ff60857c5d8e76d849bb1a0ef5378c497f0416373f38fe1adb038575980d7b5ebab71dde18f5d1f0d7d66329f73c53bdbc7743d6b075b5ebfd9da49d19b7bdb2f";
    }

    function uncompress()
        external
        view
        returns (string memory)
    {
        (InflateLib.ErrorCode err, bytes memory mem) = InflateLib.puff(data, 738);

        if (err == InflateLib.ErrorCode.ERR_NONE) {
            return string(mem);
        }
        return "";
    }
}
