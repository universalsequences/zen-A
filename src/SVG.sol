




// SPDX-License-Identifier: Apache-2.0
pragma solidity >=0.8.0 <0.9.0;
import {console} from "forge-std/console.sol";
import './Base64.sol';
import './Conversion.sol';

library SVG {
    function generateSVG(uint256 tokenId, string[3] memory colorScheme, string memory rotateN, string memory length) public view returns (string memory) {
        string memory rects = "";

        bytes memory b = bytes(rotateN);
        int rotate_n = b[0] == '2' ? int(2) : int(3);

        for (uint i=0; i < 4; i++) {
            string memory x = Conversion.uint2str((i+1)*64);
            string memory y = Conversion.uint2str((i+1)*64);
            rects = string(abi.encodePacked(
                rects,
                '<rect x="', x, '" y="', y, '" fill="rgba(', colorScheme[1], ')" width="64" height="64"/>'));
            tokenId = bitrotate(tokenId, uint(rotate_n), 8);

            uint256 extracted = extractNthBit(tokenId, i);
            if (extracted == 1) {
                string memory y2 = Conversion.uint2str((i+2)*64);
                rects = string(abi.encodePacked(
                                                rects,
                                                '<rect x="', x, '" y="', y2, '" fill="rgba(', colorScheme[2], ')" width="64" height="64"/>'));
            }
        }

        return string(abi.encodePacked("data:image/svg+xml;base64,", Base64.encode(abi.encodePacked(
            '<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" width="100%" height="100%" viewBox="0 0 512 512" xml:space="preserve">',
            '<rect x="0" y="0" width="100%" height="100%" fill="rgba(', colorScheme[0], ')"/>',
            rects,
            '</svg>'))));
    }

    /*
    function generateSVG(uint256 tokenId, string[3] memory colorScheme) public view returns (string memory) {
        string memory  rects;
        {
            rects = string(abi.encodePacked(
            '<rect rx="150" x="15" y="14" width="150" height="150" fill="url(#grid)"/>',
            '<rect x="15" y="174" width="150" height="150" rx="100" fill="url(#grid)"/>',
            '<rect x="177" y="14" width="150" height="150" fill="transparent" stroke="rgba(', colorScheme[2], ')"/>',
            '<rect x="177" y="174" width="150" height="150" fill="rgba(', colorScheme[2], ')"/>'
                                            ));
        }
        string memory  pattern;
        {
            pattern = string(abi.encodePacked(
               '<defs>',
               '<pattern id="grid" width="20" height="10" patternUnits="userSpaceOnUse">',
               '<rect x="0" y="0" width="10" height="10" fill="white"/>',
               '<line x1="0" y1="10" x2="10" y2="10" stroke="rgba(', colorScheme[1], ')" stroke-width="18"/>',
               '<line x1="10" y1="0" x2="10" y2="10" stroke="rgba(', colorScheme[1], ')" stroke-width="18"/>',
               '</pattern>',
               '</defs>'
               ));
        }
        return string(abi.encodePacked("data:image/svg+xml;base64,", Base64.encode(abi.encodePacked(
            '<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" width="100%" height="100%" viewBox="0 0 640 640" xml:space="preserve">',
            pattern,
            //'<rect x="0" y="0" width="100%" height="100%" fill="white"/>',
            '<rect x="0" y="0" width="100%" height="100%" fill="rgba(', colorScheme[0], ')"/>',
            rects,
            '</svg>'
                                                                                                    ))));
    }
    */

    function bitrotate(uint256 number, uint256 rotation, uint256 length) public view returns (uint256) {
        return rotateLeft(number, rotation, length);
   }

    function rotateLeft(uint256 n, uint256 d, uint256 totalBits) public pure returns (uint256) {
        require(totalBits <= 256, "Solidity supports maximum of 256 bits.");
        uint256 mask = (1 << totalBits) - 1; // create mask
        d = d % totalBits; // if d is greater than totalBits, we just need the remainder
        return ((n << d) | (n >> (totalBits - d))) & mask;
    }

    function rotateRight(uint256 n, uint256 d, uint256 totalBits) public pure returns (uint256) {
        require(totalBits <= 256, "Solidity supports maximum of 256 bits.");
        uint256 mask = (1 << totalBits) - 1; // create mask
        d = d % totalBits; // if d is greater than totalBits, we just need the remainder
        return ((n >> d) | (n << (totalBits - d))) & mask;
    }

     function extractNthBit(uint256 number, uint256 n) public pure returns (uint256) {
        require(n < 256, "Bit position out of range");  // Solidity supports maximum of 256 bits
        return (number >> n) & 1;
    }
}
