// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.6.2 <0.9.0;
import "./IZenLibrary.sol";
    
contract ZenLibraryWrapper {

    address public immutable wrapped;

    constructor(address _wrapped) {
        wrapped = _wrapped;
    }

    function test() external view returns (string memory) {
        return lib();
    }

    function tokenURI() external view returns (string memory) {
        return lib();
    }

    function lib() public view returns (string memory) {
       _forward();
    }

    function _forward() private view {
        function() view fView;
        function() f = __forward;
        assembly ("memory-safe") { fView := f }
        fView();
    }

    function __forward() internal {
        address wrapped_ = wrapped;
        assembly ("memory-safe") {
            calldatacopy(0x00, 0x00, calldatasize())
            let s := call(gas(), wrapped_, callvalue(), 0x00, calldatasize(), 0x00, 0x00)
            returndatacopy(0x00, 0x00, returndatasize())
            if iszero(s) {
                revert(0x00, returndatasize())
            }
            return(0x00, returndatasize())
        }
    }
}
