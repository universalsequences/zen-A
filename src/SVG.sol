// SPDX-License-Identifier: Apache-2.0
pragma solidity >=0.8.0 <0.9.0;
import {console} from "forge-std/console.sol";
import './Base64.sol';
import './Conversion.sol';

library SVG {
    function generateSVG(uint256 tokenId) public view returns (string memory) {

        /*
        uint256[256] memory numbers;

        uint256 length = 16;
        uint256 shift = uint(keccak256(abi.encodePacked(tokenId))) % 8;
        uint256 history = tokenId;
        uint256 lengthSquared = 2**length;
        for (uint256 i=0; i < 256; i++) {
            uint256 shifted = rotateRight(history, shift, length);
            uint256 b = shifted >= lengthSquared ? 1 : 0;
            uint256 xored = ((i % 24) < 12 ? 1 : 0) ^ b;
            uint rotated = shifted % lengthSquared;
            uint sum = xored + rotated;
            numbers[i] = (sum * 64) % 1024;
            history = sum;
            console.log(sum);
        }

        string memory rects = "";
        uint256 count = 0;
        for (uint256 i=0; i < 256; i+=2) {
            uint256 x = numbers[i];
            uint256 y = numbers[i+1];
            // lets get the 

            if (extractNthBit(x / 64, 2) == 0 || extractNthBit(y / 64,0) == 1) {
                string memory length = extractNthBit(x / 64, 3) == 1 ? "128" : "64";
                string memory height = extractNthBit(y / 64, 3) == 1 ? "128" : "64";
                bool flag = extractNthBit(x / 64, 0) == 1;
                if (flag) {
                    count++;
                    if (count > 5) {
                        flag = false;
                    }
                }
                string memory fill = flag ? "blue" : "transparent";
                string memory stroke = flag ? "transparent" : "blue";
                if (extractNthBit(x / 64, shift) == 1) {
                    if (flag) {
                        length = Conversion.uint2str(64 / 2**(2+count));
                    }
                    rects = string(abi.encodePacked(rects, "<circle cx=\"", Conversion.uint2str(x), "\" cy=\"", Conversion.uint2str(y), '" r="', length ,'" stroke="', stroke, '" fill="', fill, '"/>'));
                } else {
                    rects = string(abi.encodePacked(rects, "<rect x=\"", Conversion.uint2str(x), "\" y=\"", Conversion.uint2str(y), '" width="', length ,'" height="', height ,'" stroke="', stroke, '" fill="', fill, '"/>'));
                }
            }
        }
        */
        string memory svg = string(abi.encodePacked('<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" width="100%" height="100%" viewBox="0 0 1024 1024" xml:space="preserve">',
            '<rect x="0" y="0" width="100%" height="100%" fill="black"/>',
                                                    //rects,
            '</svg>'
                                                    ));
        return string(abi.encodePacked("data:image/svg+xml;base64,", Base64.encode(abi.encodePacked(svg))));
    }

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
