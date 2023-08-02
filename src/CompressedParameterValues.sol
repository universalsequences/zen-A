
pragma solidity ^0.8.20;
import "./InflateLib.sol";

contract CompressedParameterValues {
    bytes public data;

    constructor() {
        data = hex"9d52e94e06210c7c21bea6d38323beff7b392dab89fac36848760b94391830549036660ce578a17eb2d4072b518de11a21b9f7700e95b9d778198b33eb8b33bb8eeace02a9731e35cf83b10bd47af3f0bbbd3012716956ada5cf9103b97d4a1028069699f83e4549b0453172cc863578c25bda6ec5c4cc9a830a55ac56c9c513c87cc35fdd6d7fcc69d98256ed646e1ebbece7d3a09df5dde0c17a9aaab96f21407b7134260117695255e9e5b1e6025fffb36624b3d00f6f2d036c33c96c499ac334c5a83639288fd563109fe9add3e979364bb9b0ddf7d3bb651bf30916d628b69f145b74af691819cc7c8bd30f6f36b1c56e6a47946932531eb94e1df93845cfcbe9adb4f24af64e7bd386678fa71cbf8fe6faacc6857141306ccf7e7e9dc77f53f45f53043704b01f219acc3a7805867fb106ab79f8ec2b2d6010d88297027b07";
    }

    function uncompress()
        external
        view
        returns (string memory)
    {
        (InflateLib.ErrorCode err, bytes memory mem) = InflateLib.puff(data, 896);

        if (err == InflateLib.ErrorCode.ERR_NONE) {
            return string(mem);
        }
        return "";
    }
}
