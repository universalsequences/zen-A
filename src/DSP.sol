
pragma solidity ^0.8.20;
import "./IData.sol";

contract DSP {
    address dsp1;
    address dsp2;
    address dsp3;
    constructor(address a, address b, address c) {
        dsp1 = a;
        dsp2 = b;
        dsp3 = c;
    }

    function getData() public view returns  (string memory) {
        return string(
           abi.encodePacked(
              IData(dsp1).getData(),
              IData(dsp2).getData(),
              IData(dsp3).getData()
              ));
    }
}
    
 
