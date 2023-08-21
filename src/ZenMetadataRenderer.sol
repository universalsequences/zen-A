
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
import './ICompressed.sol';
import './SVG.sol';
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

    string [3][25] colorSchemes = [
                                  ["0.52, 0.47, 0.47, 1.0", "0.37, 0.21, 0.21, 1.0", "1.0, 0.07, 0.09, 1.0"],
                                  ["0.12, 0.17, 0.17, 1.0", "0.21, 0.21, 0.37, 1.0", "0.3, 0.37, 1.0, 1.0"],
                                  ["0.69, 0.6, 0.6, 1.0", "0.42, 0.49, 0.49, 1.0", "0.22, 0.97, 0.27, 1.0"],
                                  ["0.37, 0.21, 0.21, 1.0", "0.49, 0.49, 0.49, 1.0", "0.98, 0.94, 0.07, 1.0"],
                                  ["0.15, 0.13, 0.01, 1.0", "0.37, 0.41, 0.73, 1.0", "0.98, 0.08, 0.81, 1.0"],
                                   ["0.30, 0.27, 0.25, 1.0", "0.28, 0.25, 0.23, 1.0", "0.95, 0.20, 0.25, 1.0"],
    ["0.22, 0.20, 0.18, 1.0", "0.20, 0.18, 0.17, 1.0", "0.25, 0.90, 0.35, 1.0"],
    ["0.28, 0.27, 0.26, 1.0", "0.25, 0.23, 0.22, 1.0", "0.10, 0.50, 0.95, 1.0"],
    ["0.27, 0.25, 0.24, 1.0", "0.25, 0.23, 0.21, 1.0", "0.95, 0.60, 0.10, 1.0"],
    ["0.25, 0.23, 0.21, 1.0", "0.22, 0.21, 0.20, 1.0", "0.15, 0.95, 0.60, 1.0"],
    ["0.28, 0.27, 0.26, 1.0", "0.26, 0.24, 0.23, 1.0", "0.85, 0.10, 0.60, 1.0"],
    ["0.29, 0.28, 0.26, 1.0", "0.27, 0.26, 0.25, 1.0", "0.45, 0.15, 0.95, 1.0"],
    ["0.27, 0.26, 0.25, 1.0", "0.24, 0.23, 0.22, 1.0", "0.10, 0.70, 0.25, 1.0"],
    ["0.30, 0.28, 0.27, 1.0", "0.28, 0.27, 0.25, 1.0", "0.55, 0.30, 0.95, 1.0"],
    ["0.27, 0.26, 0.25, 1.0", "0.26, 0.25, 0.23, 1.0", "0.05, 0.80, 0.70, 1.0"],
    ["0.30, 0.28, 0.27, 1.0", "0.27, 0.26, 0.25, 1.0", "0.95, 0.45, 0.30, 1.0"],
    ["0.28, 0.27, 0.25, 1.0", "0.26, 0.24, 0.23, 1.0", "0.70, 0.10, 0.85, 1.0"],
    ["0.29, 0.28, 0.26, 1.0", "0.27, 0.26, 0.24, 1.0", "0.35, 0.95, 0.20, 1.0"],
    ["0.27, 0.25, 0.24, 1.0", "0.25, 0.24, 0.23, 1.0", "0.20, 0.60, 0.90, 1.0"],
    ["0.28, 0.27, 0.26, 1.0", "0.27, 0.26, 0.25, 1.0", "0.95, 0.85, 0.15, 1.0"],
    ["0.29, 0.28, 0.27, 1.0", "0.28, 0.27, 0.26, 1.0", "0.10, 0.30, 0.95, 1.0"],
    ["0.28, 0.27, 0.26, 1.0", "0.26, 0.24, 0.23, 1.0", "0.80, 0.15, 0.75, 1.0"],
    ["0.27, 0.25, 0.24, 1.0", "0.25, 0.23, 0.22, 1.0", "0.65, 0.95, 0.10, 1.0"],
    ["0.30, 0.29, 0.27, 1.0", "0.28, 0.26, 0.25, 1.0", "0.40, 0.25, 0.90, 1.0"],
    ["0.29, 0.27, 0.26, 1.0", "0.27, 0.26, 0.24, 1.0", "0.15, 0.75, 0.55, 1.0"]

                                  ];

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

    function getColorScheme(uint256 tokenId) public view returns (string[3] memory ) {
        uint colorId = uint(uint(keccak256(abi.encodePacked(tokenId))) % colorSchemes.length);
        return colorSchemes[colorId];
    }

    function generateColorScheme(uint256 tokenId) public view returns (string memory) {
        uint colorId = uint(uint(keccak256(abi.encodePacked(tokenId))) % colorSchemes.length);
        return string(
            abi.encodePacked(
                "const color1 = \"", colorSchemes[colorId][0], "\";\n",
                "const color2 = \"", colorSchemes[colorId][1], "\";\n",
                "const color3 = \"", colorSchemes[colorId][2], "\";\n"));
    }

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
              "\"description\": \"Zen A by A.L.E.Z. Dynamically generated music, fully onchain. 2 shift-register sequencers fighting eachother, while strictly adhering to Jaki Leibezeit's dot dash system. Built with Zen. \", ", 
              //"\"image\": \"", SVG.generateSVG(tokenId, getColorScheme(tokenId)), "\",",
              getTraits(tokenId), ",",
              "\"name\": \"Zen A", Conversion.uint2str(tokenId), "\", ", 
              "\"animation_url\": \"",

            string(abi.encodePacked(
            "data:text/html;base64,",
            Base64.encode(abi.encodePacked(generateHTML(tokenId))))), "\"", 
              
                                                   
              "}"
                             )))));
    }

    function generateFloatVariable(string memory name, uint256 tokenId) public view returns (string memory) {
        uint num = 1 + uint(uint(keccak256(abi.encodePacked(tokenId))) % 100);
        return string(abi.encodePacked(
                                       "const ", name, " = ", Conversion.uint2str(num), "/ 101.0;"));
    }

    function generateIntVariable(string memory name, uint256 tokenId, uint256 max) public view returns (string memory) {
        uint num = uint(uint(keccak256(abi.encodePacked(tokenId))) % max);
        return string(abi.encodePacked(
                                       "const ", name, " = \"", Conversion.uint2str(num), ".0\";"));
    }

    function getTraits(uint256 tokenId) public view returns (string memory) {
        string memory scaleName = scaleNames[tokenId == 1 ? 0 : tokenId % 2];
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
        return scales[tokenId == 1 ? 0 : tokenId % 2];
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

        uint latchBase = (tokenId < 10 ? 13 : 24) - (tokenId < 100 ? (tokenId / 8) : 12);

        uint [] memory counts = new uint[](parameterValues.length);
        uint count = 0;
        for (uint i=0; i < parameterNames.length; i++) {
            // Use the pseudorandom number to select a preset for this parameter
            if ( i % latchedWidth == 0) {
                latched = tokenId <= 6 ? tokenId - 1 : (uint(keccak256(abi.encodePacked(tokenId, '-', i))) % parameterValues.length);

                // 8 was good but lets try 3 to go even crazier
                latchedWidth = (latchBase + (uint(keccak256(abi.encodePacked(tokenId, '-', i)))) % 15);
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

    function generateMyPage(uint256 tokenId) external view returns (string memory) {
        return string(abi.encodePacked(
            "data:text/html;base64,",
            Base64.encode(abi.encodePacked(generateHTML(tokenId)))));
    }

    function generateHTML(uint256 tokenId) public view returns (string memory) {
        bytes memory part1;
        {
            part1 = abi.encodePacked(
            '<!DOCTYPE html><html lang="en"><head>',
            '<meta charset="UTF-8">',
            '<meta name="viewport" content="width=device-width, initial-scale=1.0">',
            '<title>Music Generator</title>'
            '</head>'
            '<body style="background-color: white; display: flex; margin: 0">'
            '<div id="playButton" style="position: absolute; z-index: 30; width: 0; height: 0; border-top: 30px solid transparent; border-bottom: 30px solid transparent; border-left: 60px solid #E2E5DE; margin: auto; position: absolute; top: 0; right: 0; bottom: 0; left: 0;"></div>'
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
                                        ';\nlet ctxt = new (window.AudioContext || window.webkitAudioContext)({sampleRate:44100});\n'
            'if (!gainNode) gainNode  = ctxt.createGain(); \n'
            'if (ctxt.state === "suspended") {\n ctxt.resume();\n}\n'
            'if (!workletNode) {\n'
                'createWorklet(ctxt, zen(x)).then(z => {\n'
                        'workletNode = z.workletNode;\n'
                        'const compressor = ctxt.createDynamicsCompressor();\n'
                        'compressor.threshold.value = -11;  \n'
                         'compressor.knee.value = 2;  \n'
                          'compressor.ratio.value = 3;  \n'
'compressor.attack.value = 0.001;  \n'
'compressor.release.value = 0.25;\n'
                                    'gainNode.connect(compressor);\n'
                        'compressor.connect(ctxt.destination);\n'
                        'z.workletNode.connect(gainNode);\n'
                             'workletNode.port.onmessage = (e) => {\n'
                            'let {type, body} = e.data\n'
'if (type === "phase") {\n'
 '    update("kickEnv", body);\n'
'}\n'
'if (type === "bit") {\n'
'    updateBit(body);\n'
'}\n'

                                'if (type === "kickEnv") {\n'
                                    'update("phase", body*0.5);\n'
                                                                   '}}});'
            '}\n'
                  'gainNode.gain.setValueAtTime(isPlaying ? 2.5 : 0, ctxt.currentTime);\n');
            }

            bytes memory part3;
            {
                part3 = abi.encodePacked(
            '}\n', // end of generate music func
                  'const gridSize = (\"', Conversion.uint2str(uint(uint(keccak256(abi.encodePacked(tokenId))) % 100) < 50 ? 32 : 16), '.000\");\n',
                  generateFloatVariable("crossSize", tokenId),
                  generateIntVariable("yRate", tokenId, 100),

                  generateColorScheme(tokenId),
            ICompressed(shaderWrapper).uncompress(),
            '</script>',
            '</body>',
            '</html>'
            );
            }

        return string(abi.encodePacked(part1, part2, part3));
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
