// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10; 
import "./IZoraNFTCreator.sol";
//import './SVG.sol';
import './Base64.sol';
import {IERC721Drop} from "zora-drops-contracts/interfaces/IERC721Drop.sol";
import {console} from "forge-std/console.sol";
import {ERC721Drop} from "zora-drops-contracts/ERC721Drop.sol";

contract ZenDropCreator {

    string [] gray= ["45.0,47.0,45.0,255.0", "90.0,85.0,85.0", "20.0, 20.0, 20.0, 255.0"];
    IERC721Drop.SalesConfiguration salesConfig;
    address zporeMinterAddress;

    bytes32 public immutable DEFAULT_ADMIN_ROLE = 0x00;
    bytes32 public immutable MINTER_ROLE = keccak256("MINTER");

    // creatorAddress is the address of the zora-deployed "drop creator" 
    constructor() {

        salesConfig = IERC721Drop.SalesConfiguration({
            publicSalePrice: 0,
            maxSalePurchasePerAddress: 1024,
            publicSaleStart: 0,
            publicSaleEnd: 500000000000000,
            presaleStart: 0,
            presaleEnd: 0,
            presaleMerkleRoot: 0x0
            });
    }
    

    // A reusable function for creating new drops using Zoras Drop contracts
    // with the initial media set 

    function newDrop(address metadataRenderer) public returns (address) {
        // need to register shit with ZporeMinter at "defaultAdmin"
        bytes memory metadataInitializer = abi.encode(
            string(abi.encodePacked(
                "data:application/json;base64,",
                Base64.encode(
                    bytes(
                        string(
                            abi.encodePacked(
                                             //'{"description": "1024 eternal compositions (100% on-chain).", "name": "Bleep A", "image": "', SVG.generateSVG(1029, gray) ,'"}')))))));
                                             '{"description": "1024 eternal compositions (100% on-chain).", "name": "Bleep A"}')))))));

        // new goerli version:
        //address ZORA_DROPS_CREATOR = address(0xb9583D05Ba9ba8f7F14CCEe3Da10D2bc0A72f519);

        // zora goerli network
        address ZORA_DROPS_CREATOR = address(0xeB29A4e5b84fef428c072debA2444e93c080CE87);
        address newDropAddress = IZoraNFTCreator(ZORA_DROPS_CREATOR).setupDropsContract(
          "Bleep A",
          "BLPA",
          address(this),
          1024, // unlimited?
          500, // BPS (what should i do for 8%?)
          payable(address(this)),
          salesConfig,
          IMetadataRenderer(metadataRenderer),
          metadataInitializer,
          address(0)
       );

        // return the new drop address so that Stems contract can tie the "song" to the
        // remixes address
        return newDropAddress;
    }

}
