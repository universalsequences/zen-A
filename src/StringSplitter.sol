// SPDX-License-Identifier: MIT

pragma solidity >=0.8.0 <0.9.0;

library StringSplitter {
    // Split a string by a delimiter
    function split(string memory _str, string memory _delimiter) internal pure returns (string[] memory) {
        bytes memory str = bytes(_str);
        bytes memory delimiter = bytes(_delimiter);

        uint count = 1;
        for(uint i = 0; i < str.length; i++)
            if(str[i] == delimiter[0]) count++;

        string[] memory arr = new string[](count);

        bytes memory word = new bytes(str.length);
        uint length = 0;
        uint j = 0;
        for(uint i = 0; i < str.length; i++) {
            if(str[i] == delimiter[0]) {
                arr[j] = new string(length);
                for(uint k = 0; k < length; k++) {
                    bytes(arr[j])[k] = word[k];
                }
                length = 0;
                j++;
            } else {
                word[length] = str[i];
                length++;
            }
        }
        
        arr[j] = new string(length);
        for(uint k = 0; k < length; k++) {
            bytes(arr[j])[k] = word[k];
        }
        
        return arr;
    }

    // Split a string into a 2D array using two delimiters
    function split2D(string memory _str, string memory _delimiter1, string memory _delimiter2) internal pure returns (string[][] memory) {
        string[] memory outerArray = split(_str, _delimiter1);
        string[][] memory arr = new string[][](outerArray.length);

        for(uint i = 0; i < outerArray.length; i++) {
            arr[i] = split(outerArray[i], _delimiter2);
        }

        return arr;
    }
}
