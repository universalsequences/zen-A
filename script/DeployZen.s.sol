
// SPDX-License-Identifier: MIT

pragma solidity >=0.8.0 <0.9.0;
import "forge-std/Script.sol";
import "../src/CompressedLibrary.sol";
import "../src/CompressedShader.sol";
import "../src/CompressedDSP.sol";
import "../src/CompressedParameterNames.sol";
import "../src/CompressedParameterValues.sol";
import "../src/ZenDropCreator.sol";
import "../src/ZenMetadataRenderer.sol";

contract DeployZen is Script {
    function run() external {
  
    uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
    vm.startBroadcast(deployerPrivateKey);

    CompressedLibrary lib = new CompressedLibrary();
    CompressedDSP dsp = new CompressedDSP();
    CompressedParameterNames  names = new CompressedParameterNames();
    CompressedParameterValues values = new CompressedParameterValues();
    CompressedShader shader = new CompressedShader();
    ZenMetadataRenderer metadataRenderer = new ZenMetadataRenderer(
        address(lib), address(dsp), address(names), address(values), address(shader));
    ZenDropCreator creator = new ZenDropCreator();
    address drop = creator.newDrop(address(metadataRenderer));
    IERC721Drop(drop).purchase{value:1554000000000000*0}(200);
    vm.stopBroadcast();
  }
}
