

// SPDX-License-Identifier: Apache-2.0
pragma solidity >=0.8.0 <0.9.0;
import {console} from "forge-std/console.sol";
import './Base64.sol';
import './Conversion.sol';

library SVG {
    function generateSVG(uint256 tokenId, string[3] memory colorScheme) public view returns (string memory) {
        uint256[512] memory numbers;

        uint256 shift = uint(keccak256(abi.encodePacked(tokenId))) % 8;
        uint256 history = tokenId;
        uint256 lengthSquared = 2**16;
        for (uint256 i=0; i < 64; i++) {
            uint256 shifted = rotateRight(history, shift, 16);
            uint256 b = shifted >= lengthSquared ? 1 : 0;
            uint256 xored = ((i % 24) < 12 ? 1 : 0) ^ b;
            uint rotated = shifted % lengthSquared;
            uint sum = xored + rotated;
            numbers[i] = (sum * 64) % 1024;
            history = sum;
        }

        string memory rects = "";
        for (uint256 i=0; i < 32; i++) {
            uint256 x = numbers[i];
            uint256 y = numbers[i*2];
            bool flag = extractNthBit(x / 64, 0) == 1 || extractNthBit(x / 64, 3) == 1 || extractNthBit(x / 64, 4) == 1 || extractNthBit(x / 64, 5) == 1;
            x = flag ? numbers[i] + 128 + 32 : numbers[i];
            y = flag ? numbers[i+1] + 128 + 32 : numbers[i];
            x += 64;
            y += 64;
            // lets get the 

            if (extractNthBit(x / 64, 2) == 0 || extractNthBit(y / 64,0) == 1) {
                uint _length;
                {
                    _length = extractNthBit(x / 64, 3) == 1 ? 256 : 128;
                }
                if (x + _length >= 1024  || y + _length >= 1024 ) {
                    continue;
                }

                if (flag) {
                    x -= 64;
                    y -= 64;
                }
                string memory length;
                {
                    length = Conversion.uint2str(_length);
                }
                //string memory height;
                //{
                //    height = extractNthBit(y / 64, 3) == 1 ? "128" : "64";
                //}
                if (flag) {
                }
                string memory fill;
                {
                    //fill = flag ? string(abi.encodePacked("rgba(", colorScheme[2], ")")) : "transparent";
                    fill = flag ? (extractNthBit(x / 64, 2) == 0 ? string(abi.encodePacked("rgba(", colorScheme[2], ")")) : string(abi.encodePacked("rgba(30,30,30,255)"))) : "transparent";
                }
                string memory stroke;
                {
                    stroke = flag ? "transparent" : string(abi.encodePacked("rgba(", colorScheme[2], ")"));
                }
               string memory strokeWidth = "1";
                rects = string(abi.encodePacked(rects, "<rect opacity=\".8\" stroke-width=\"", strokeWidth, "\" x=\"", Conversion.uint2str(x), "\" y=\"", Conversion.uint2str(y), '" width="', length, '" height="' , length, '" stroke="', stroke, '" fill="', fill, '"/>'));
            }
        }
        string memory svg = string(abi.encodePacked('<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" width="100%" height="100%" viewBox="0 0 1024 1024" xml:space="preserve">',
            '<rect x="0" y="0" width="100%" height="100%" fill="rgba(', colorScheme[0], ')"/>',
                                                    rects,
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
