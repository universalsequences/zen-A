

// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.6.2 <0.9.0;

import "forge-std/Script.sol";
//import {IERC721Drop} from "zora-drops-contracts/interfaces/IERC721Drop.sol";
//import "../src/ZenMetadataRenderer.sol";
import "../src/ZenLibrary.sol";
import "../src/IZenLibrary.sol";
import "../src/ZenLIbraryWrapper.sol";
import "../src/ZenDropCreator.sol";
import "../src/ZenMetadataRenderer.sol";
import "../lib/zipped-contracts/script/ZDeployBase.sol";

contract Deploy is ZDeployBase {
    function run() external {
        Z z = _getOrDeployZ();
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);
        //vm.startBroadcast();
        // Deploy as a ZCALL contract:
        //ZenLibrary lib = new ZenLibrary("HELLO WORLD");
        IZenLibrary lib = IZenLibrary(_zcallDeploy(abi.encodePacked(
            type(ZenLibrary).creationCode
        ), z));

        ZenLibraryWrapper libWrapper = new ZenLibraryWrapper(address(lib));
        /*
        ZenMetadataRenderer metadataRenderer = new ZenMetadataRenderer(address(libWrapper));
        ZenDropCreator creator = new ZenDropCreator();
        address drop = creator.newDrop(address(metadataRenderer));
        IERC721Drop(drop).purchase{value:1554000000000000}(2);
        */
        vm.stopBroadcast();

        //console.log(lib.lib());
        //console.log(lib.lib());
        /*
        IZenLibrary deployed = IZenLibrary(_zrunDeploy(abi.encodePacked(
            type(ZenLibrary).creationCode
        ), z));
        console.log(deployed.exec(true));
        */


        //console.log(lib.getLibrary());

        // or deploy as a ZRUN contract:
        //_zrunDeploy(type(MyContract).creationCode, z);
    }
}

/*
contract CounterScript is Script {
    function setUp() public {}

    function run() public {
        //address ZORA_DROPS_CREATOR = address(0xEf440fbD719cC5c3dDCD33b6f9986Ab3702E97A5);
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);
        ZenTest lib = new ZenTest();

        vm.stopBroadcast();
    }
}

*/
