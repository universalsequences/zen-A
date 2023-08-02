
pragma solidity ^0.8.20;
import "./InflateLib.sol";

contract CompressedParameterValues {
    bytes public data;

    constructor() {
        data = hex"754f810a424108fb2113dda9a7f4ffffd5ae47514120e26ddedc4c2bb6384c6e2ea6be5bb03275ac24651132879c3a2c923d6a484097c7a157cb446b3aeedc48481126b18bff2d42b39bfb4f298ab6dc70c61cf65c45c27570619c3d933a6df9d271830c42a7f1e9a8046f47b682af970ccaa592feea383af110765dfd17af7ee2c557bc8dd18df500";
    }

    function uncompress()
        external
        view
        returns (string memory)
    {
        (InflateLib.ErrorCode err, bytes memory mem) = InflateLib.puff(data, 299);

        if (err == InflateLib.ErrorCode.ERR_NONE) {
            return string(mem);
        }
        return "";
    }
}
