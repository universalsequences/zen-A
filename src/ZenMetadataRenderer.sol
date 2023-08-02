
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
import './ICompressed.sol';
import './StringSplitter.sol';
import {IMetadataRenderer} from "zora-drops-contracts/interfaces/IMetadataRenderer.sol";
import './Base64.sol';
import './Conversion.sol';
import {MetadataRenderAdminCheck} from "zora-drops-contracts/metadata/MetadataRenderAdminCheck.sol";
import './IZenLibrary.sol';

contract ZenMetadataRenderer is IMetadataRenderer, MetadataRenderAdminCheck {


    address libraryWrapper;
    address dspWrapper;
    address parameterNamesWrapper;
    address parameterValuesWrapper;
    address shaderWrapper;
    string signature;
    string [2] scaleNames = ["mixolydian", "ukranian dorian"];
    string [2] scales = ["[0,2,4,5,7,9,10]", "[0,2,3,6,7,9,10]"];


    constructor(address wrapper, address dsp, address namesWrapper, address valuesWrapper, address shader) {
        libraryWrapper = wrapper;
        dspWrapper = dsp;
        parameterNamesWrapper = namesWrapper;
        parameterValuesWrapper = valuesWrapper;
        shaderWrapper = shader;
    }


    struct MetadataURIInfo {
        string contractURI;
    }

    /// @notice NFT metadata by contract
    mapping(address => MetadataURIInfo) public metadataBaseByContract;

    function getParameterNames() public view returns (string [] memory) {
        return StringSplitter.split(ICompressed(parameterNamesWrapper).uncompress(), ",");
    }

    function getParameterValues() public view returns (string [][] memory) {
        return StringSplitter.split2D(ICompressed(parameterValuesWrapper).uncompress(), ";", ",");
    }

    function lib(address x) external view returns (string memory) {
        return IZenLibrary(x).lib();
    }

    function tokenURI(uint256 tokenId) external view returns (string memory) {
        return string(abi.encodePacked(
          'data:application/json;base64,',
          Base64.encode(bytes(
            abi.encodePacked(
              "{",
              "\"description\": \"testing open-sea.\", ", 
              "\"image\": \"", generateSVG(), "\",",
              getTraits(tokenId), ",",
              "\"name\": \"ZEN!\", ", 
              "\"animation_url\": \"",

            string(abi.encodePacked(
            "data:text/html;base64,",
            Base64.encode(abi.encodePacked(generateHTML(tokenId))))), "\"", 
              
                                                   
              "}"
                             )))));
    }

    function getTraits(uint256 tokenId) public view returns (string memory) {
        string memory scaleName = scaleNames[tokenId % 2];
        string memory attr = string(abi.encodePacked(
            "\"attributes\": [{\"trait_type\": \"scale\", \"value\": \"", scaleName, "\"},"));
            
        string [] memory names = getParameterNames();
        (string [] memory generated, string [] memory stats) = generateParameters(tokenId);
        for (uint256 i=0; i < stats.length; i++) {
            attr = string(abi.encodePacked(attr, "{\"trait_type\": \"Gene #", Conversion.uint2str(i+1),"\", \"value\": \"", stats[i], "\"}"));
            attr = string(abi.encodePacked(attr, ","));
        }
        for (uint256 i=0; i < generated.length; i++) {
            attr = string(abi.encodePacked(attr, "{\"trait_type\": \"", names[i] ,"\", \"value\": \"", generated[i], "\"}"));
            if (i < generated.length - 1) {
                attr = string(abi.encodePacked(attr, ","));
            }
        }
        return string(abi.encodePacked(attr, "]"));
    }

    function generateSignature() public view returns (string memory) {
        string memory sig = "function dsp(inputScale,";
        string [] memory parameterNames = getParameterNames();
        for (uint i=0; i < parameterNames.length; i++) {
            sig = string(abi.encodePacked(
                sig, parameterNames[i]));
            if (i < parameterNames.length - 1) {
                sig = string(abi.encodePacked(
                   sig, ","));
            }
        }
        return string(abi.encodePacked(sig, ")"));
    }

    function getScale(uint256 tokenId) public view returns (string memory) {
        return scales[tokenId % 2];
    }

    function generateDSPCall(uint256 tokenId) public view returns (string memory) {
        string memory scale = getScale(tokenId);
        string memory sig = string(abi.encodePacked("dsp(", scale, ","));
        (string [] memory generated, string [] memory stats) = generateParameters(tokenId);

        for (uint i=0; i < generated.length; i++) {
            // Add the value from the selected preset to the function call
            sig = string(abi.encodePacked(sig, generated[i]));
            
            if (i < generated.length - 1) {
                sig = string(abi.encodePacked(sig, ","));
            }
        }
        return string(abi.encodePacked(sig, ")"));
    }

    function generateParameters(uint256 tokenId) public view returns (string [] memory, string [] memory) {
        string memory scale = getScale(tokenId);
        string memory sig = string(abi.encodePacked("dsp(", scale, ","));
        uint latched = 0;
        string [] memory parameterNames = getParameterNames();
        string [][] memory parameterValues = getParameterValues();

        string[] memory arr = new string[](parameterNames.length);

        uint latchedWidth = 1; 

        uint latchBase = 13 - (tokenId < 100 ? (tokenId / 8) : 12);

        uint [] memory counts = new uint[](parameterValues.length);
        uint count = 0;
        for (uint i=0; i < parameterNames.length; i++) {
            // Use the pseudorandom number to select a preset for this parameter
            uint presetIndex = uint(keccak256(abi.encodePacked(tokenId, '-', i))) % parameterValues.length;

            if ( i % latchedWidth == 0) {
                latched = tokenId <= 4 ? tokenId - 1 : presetIndex;
                // 8 was good but lets try 3 to go even crazier
                latchedWidth = (latchBase + (uint(keccak256(abi.encodePacked(tokenId, '-', i)))) % (parameterValues.length - 2));
            }
            arr[i] = parameterValues[latched%parameterValues.length][i];
            counts[latched%parameterValues.length]++;
            count++;
        }

        string [] memory stats = new string[](parameterValues.length);
        for (uint i=0; i < parameterValues.length; i++) {
            uint avg = 100*counts[i] / count;
            stats[i] = Conversion.uint2str(avg);
        }
        
        return (arr, stats);
    }

    function generateSVG() public view returns (string memory) {
        string memory svg = string(abi.encodePacked('<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" width="1080" height="1080" viewBox="0 0 1080 1080" xml:space="preserve">',
            '<rect x="0" y="0" width="100%" height="100%" fill="transparent"/>',
            '<rect x="-540" y="-540" rx="0" ry="0" width="1080" height="1080" fill="black"/>'
            '</svg>'
                                                    ));
        return string(abi.encodePacked("data:image/svg+xml;base64,", Base64.encode(abi.encodePacked(svg))));
    }

    function generateMyPage(uint256 tokenId) external view returns (string memory) {
        return string(abi.encodePacked(
            "data:text/html;base64,",
            Base64.encode(abi.encodePacked(generateHTML(tokenId)))));
    }

    function generateHTML(uint256 tokenId) public view returns (string memory) {
        /*
            part1 = string(abi.encodePacked(
            "data:text/html;base64,",
        */
        bytes memory part1;
        {
            part1 = abi.encodePacked(
            '<!DOCTYPE html><html lang="en"><head>',
            '<meta charset="UTF-8">',
            '<meta name="viewport" content="width=device-width, initial-scale=1.0">',
            '<title>Music Generator</title>'
            '</head>'
            '<body style="background-color: white; display: flex; margin: 0">'
            '<div id="playButton" onclick="generateMusic()" style="position: absolute; z-index: 30; width: 0; height: 0; border-top: 30px solid transparent; border-bottom: 30px solid transparent; border-left: 60px solid #E2E5DE; margin: auto; position: absolute; top: 0; right: 0; bottom: 0; left: 0;"></div>'
            '<script>',
            ICompressed(libraryWrapper).uncompress(),
            ';let isPlaying = false;'
            ';let workletNode, gainNode;',
            generateSignature(),
            '{ \n',
             'let history = window.ZEN_LIB.history;\n',
             ICompressed(dspWrapper).uncompress()
                                                       );

        }

        bytes memory part2;
            
        {
            part2 = abi.encodePacked(
            '\n}\n'
            '\nfunction generateMusic() {'
            'const button = document.getElementById("playButton");'
            'if (isPlaying) {'
                'button.style.borderTop = "30px solid transparent";'
                'button.style.borderBottom = "30px solid transparent";'
                'button.style.borderLeft = "60px solid #E2E5DE";'
                'button.style.width= "0";'
                'button.style.height= "0";'
                'button.style.borderRight = "0";'
            '} else {'
                'button.style.width= "30px";'
                'button.style.height= "80px";'
                'button.style.borderTop = "0";'
                'button.style.borderBottom = "0";'
                'button.style.borderLeft = "30px solid #E2E5DE";'
                'button.style.borderRight = "30px solid #E2E5DE";'
            '}'
            'isPlaying = !isPlaying;\n'
            'let x = ',
                                        generateDSPCall(tokenId),
                                        ';\nlet ctxt = new (window.AudioContext || window.webkitAudioContext)();\n'
            'if (!gainNode) gainNode  = ctxt.createGain(); \n'
            'if (ctxt.state === "suspended") {\n txt.resume();\n}\n'
            'if (!workletNode) {\n'
                'createWorklet(ctxt, zen(x)).then(z => {\n'
                        'workletNode = z.workletNode;\n'
                        'const compressor = ctxt.createDynamicsCompressor();\n'
                        'compressor.threshold.value = -10;  \n'
                         'compressor.knee.value = 1;  \n'
                          'compressor.ratio.value = 3;  \n'
'compressor.attack.value = 0.001;  \n'
'compressor.release.value = 0.25;\n'
                                    'gainNode.connect(compressor);\n'
                        'compressor.connect(ctxt.destination);\n'
                        'z.workletNode.connect(gainNode);\n'
                             'workletNode.port.onmessage = (e) => {\n'
                            'let {type, body} = e.data\n'
                            'if (type === "kickEnv") {\n'
                                'update("variable3", body*4);\n'
                                '}\n'
                                'if (type === "clapEnv") {\n'
                                    'update("variable4", body);\n'
                                                                   '}}});'
            '}\n'
            'gainNode.gain.setValueAtTime(isPlaying ? 2 : 0, ctxt.currentTime);\n'
            '}', // end of generate music func
            ICompressed(shaderWrapper).uncompress(),
            '</script>',
            '<canvas id="canvas" style="width: 100vw; height: 100vh;"></canvas>',

            '</body>',
            '</html>'
            );
            }

            return string(abi.encodePacked(part1, part2));
    }

    function contractURI() external view returns (string memory) {
        string memory uri = metadataBaseByContract[msg.sender].contractURI;
        if (bytes(uri).length == 0) revert();
        return uri;
    }

    function initializeWithData(bytes memory data) external {
        // data format: string baseURI, string newContractURI
        (string memory initialContractURI) = abi
            .decode(data, (string));

        metadataBaseByContract[msg.sender] = MetadataURIInfo({
            contractURI: initialContractURI}
        );
    }
}
