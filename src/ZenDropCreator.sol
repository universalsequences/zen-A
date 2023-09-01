
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10; 
import "./IZoraNFTCreator.sol";
import './SVG.sol';
import './Base64.sol';
import {IERC721Drop} from "zora-drops-contracts/interfaces/IERC721Drop.sol";
import {console} from "forge-std/console.sol";
import {ERC721Drop} from "zora-drops-contracts/ERC721Drop.sol";

contract ZenDropCreator {

    string [3] gray= ["45.0,47.0,45.0,255.0", "90.0,85.0,85.0", "20.0, 20.0, 20.0, 255.0"];
    IERC721Drop.SalesConfiguration salesConfig;
    address zporeMinterAddress;

    constructor() {
        salesConfig = IERC721Drop.SalesConfiguration({
            publicSalePrice: 0*7000000000000000,
            maxSalePurchasePerAddress: 500,
            publicSaleStart: 0,
            publicSaleEnd: 500000000000000,
            presaleStart: 0,
            presaleEnd: 0,
            presaleMerkleRoot: 0x0
            });
    }

    function newDrop(address metadataRenderer) public returns (address) {
        bytes memory metadataInitializer = abi.encode(
            string(abi.encodePacked(
                "data:application/json;base64,",
                Base64.encode(bytes(string(abi.encodePacked(
                    '{"image": "', SVG.generateSVG(1024, gray, "3", "8"), '", "description": "Collection of 512 real-time audiovisual compositions, onchain. CCO license.", "name": "Bleep A"}')))))));

        // ZORA_NFT_CREATOR_PROXY (zora network)
        //address ZORA_DROPS_CREATOR = address(0xA2c2A96A232113Dd4993E8b048EEbc3371AE8d85);

        // ZORA_NFT_CREATOR_PROXY (zora goerli network)
        address ZORA_DROPS_CREATOR = address(0xeB29A4e5b84fef428c072debA2444e93c080CE87);

        address newDropAddress = IZoraNFTCreator(ZORA_DROPS_CREATOR).setupDropsContract(
          "Bleep A", 
          "BLPA",
          msg.sender, // admin of contract
          512,  // number of editions
          800, // BPS (8%?)
          payable(msg.sender), // funds recipient
          salesConfig, // datastructure on pricing etc
          IMetadataRenderer(metadataRenderer), 
          metadataInitializer, // blob w/ description and cover
          address(0)
       );

        return newDropAddress;
    }

}
