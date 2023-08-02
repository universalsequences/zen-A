
pragma solidity ^0.8.20;
import "./InflateLib.sol";

contract CompressedParameterNames {
    bytes public data;

    constructor() {
        data = hex"5d534b96dc200cbc501636603e17c82eb9829e40a2ed8c6d1c9bee49df3ec2ee3733c9528590aa8a6283ae536670b0f23bd46961389e47e5e5db069df13e32fcc2b7091e3cc332ad0d8d316803110ffebef3ef3bafe9d9e0947cefa1a48a0f6e3559a3b8b51df028b3207dd7b9849f1d7d183ce52f7576030d403ce313deb90aa4a29675b0f351565c53eb52490b0148336eafb98a346a25b4d73a2ae99d9185db7960b2f6b0978a95e1674372401f61e6f55647a9f5e0ec6001e7da049634d5a7ecdf5e67014d80bcc8e88d991ae4fb5e0b2455c4f4d6901462c89719cb8fd29a4c8e3ebb9780413967228c138c585f7c07a3642bc4a9423992b8fae70293e93fbc3ea9086c8d2cf4179c970bf0ce02e1310ad38467538896eca72acb3d26fddf021734bbeeab197ee8745313afc91e1547ba6c3ca007f5ba187a6f45e269f8365ece060e3874b014bacfb88bb639b7e89c27c9726e439554d8593764a8fb7483f7894e76e83bd321acf745081e02c49e599242fb7d818cc470c62c86e45b2a3fdba2d1de43bad79233f0fa80051bbf98bd3674f1a3e9214832a117d36ff3447c96c9e91e24d35b815dd437cc3adb67382aee55e637c48540f1fc051f1f20894aeadbb3dd97b55d235946f4af1e624a0e65d48ed36dacf0369dc9a01c12aaf311e65c04e08e0d491af9c17b84c82bf12eb02434a2072af5e33db3d399146ce5a88029f1daf8e5a0ba64e5a99aebade68194159125e27cda21c96fc1ff0b";
    }

    function uncompress()
        external
        view
        returns (string memory)
    {
        (InflateLib.ErrorCode err, bytes memory mem) = InflateLib.puff(data, 977);

        if (err == InflateLib.ErrorCode.ERR_NONE) {
            return string(mem);
        }
        return "";
    }
}
