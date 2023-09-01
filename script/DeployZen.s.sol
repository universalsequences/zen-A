

// SPDX-License-Identifier: MIT

pragma solidity >=0.8.0 <0.9.0;
import "forge-std/Script.sol";
import "../src/CompressedLibrary0.sol";
import "../src/DSP.sol";
import "../src/CompressedLibrary1.sol";
import "../src/CompressedLibrary2.sol";
import "../src/CompressedLibrary.sol";
import "../src/CompressedShader.sol";
import "../src/CompressedColors.sol";
import "../src/CompressedDSP0.sol";
import "../src/CompressedDSP1.sol";
import "../src/CompressedDSP2.sol";
import "../src/CompressedParameterNames0.sol";
import "../src/CompressedParameterValues0.sol";
import "../src/ZenDropCreator.sol";
import "../src/ZenMetadataRenderer.sol";

contract DeployZen is Script {
    function run() external {
  
    uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
    vm.startBroadcast(deployerPrivateKey);

    CompressedLibrary0 lib1 = new CompressedLibrary0();
    CompressedLibrary1 lib2 = new CompressedLibrary1();
    CompressedLibrary2 lib3 = new CompressedLibrary2();
    CompressedColors colors = new CompressedColors();
    DSP dsp;
    {
    CompressedDSP0 dsp0 = new CompressedDSP0();
    CompressedDSP1 dsp1 = new CompressedDSP1();
    CompressedDSP2 dsp2 = new CompressedDSP2();
    dsp = new DSP(address(dsp0),address( dsp1), address(dsp2));
    }
    CompressedParameterNames0  parameterNames = new CompressedParameterNames0();
    CompressedParameterValues0 parameterValues  = new CompressedParameterValues0();
    CompressedShader shader = new CompressedShader();

    ZenMetadataRenderer metadataRenderer = new ZenMetadataRenderer(
        address(lib1),
        address(lib2),
        address(lib3),
        address(dsp),
        address(parameterNames),
        address(parameterValues),
        address(shader),
        address(colors));
    ZenDropCreator creator = new ZenDropCreator();

    address drop = creator.newDrop(address(metadataRenderer));
    IERC721Drop(drop).purchase{value:(777000000000000 + 0*7000000000000000)*128}(128);
    vm.stopBroadcast();
  }
}
