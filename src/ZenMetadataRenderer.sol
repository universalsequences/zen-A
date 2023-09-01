

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
import './IData.sol';

contract ZenMetadataRenderer is IMetadataRenderer, MetadataRenderAdminCheck {


    address private colorsWrapper;
    address private libraryWrapper1;
    address private libraryWrapper2;
    address private libraryWrapper3;
    address private dspWrapper;
    address private parameterNamesWrapper;
    address private parameterValuesWrapper;
    address private shaderWrapper;
    string [4] private scaleNames = ["mixolydian", "ukranian dorian", "dorian", "ukranian dorian (alt)"];
    string [4] private scales = ["[0,2,4,5,7,9,10]", "[0,2,3,6,7,9,10]", "[0,2,3,5,7,9,10]", "[0,2.1,3.03,6,6.9,9,10.1]"];

    string [3][25] private colorSchemes = [
                                           ["133.0, 120.0, 120.0, 255.0", "94.0, 54.0, 54.0, 255.0", "255.0, 0.0, 0.0, 255.0"],
    ["31.0, 43.0, 43.0, 255.0", "54.0, 54.0, 94.0, 255.0", "51.0, 51.0, 255.0, 255.0"],
    ["26.0, 53.0, 53.0, 255.0", "7.0, 5.0, 50.0, 255.0", "0.0, 255.0, 0.0, 255.0"],
    ["94.0, 54.0, 54.0, 255.0", "125.0, 125.0, 125.0, 255.0", "255.0, 102.0, 0.0, 255.0"],
    ["38.0, 33.0, 3.0, 255.0", "94.0, 105.0, 186.0, 255.0", "255.0, 0.0, 255.0, 255.0"],
    ["37.0, 39.0, 34.0, 255.0", "71.0, 64.0, 59.0, 255.0", "255.0, 51.0, 64.0, 255.0"],
    ["56.0, 51.0, 46.0, 255.0", "51.0, 46.0, 43.0, 255.0", "64.0, 255.0, 89.0, 255.0"],
                                           ["126.0, 88.0, 255.0, 255.0", "64.0, 59.0, 56.0, 255.0", "126.0, 98.0, 255.0, 255.0"],
    ["39.0, 34.0, 31.0, 255.0", "64.0, 59.0, 54.0, 255.0", "255.0, 153.0, 26.0, 255.0"],  
    ["64.0, 59.0, 54.0, 255.0", "56.0, 54.0, 51.0, 255.0", "38.0, 255.0, 153.0, 255.0"],
    ["41.0, 39.0, 36.0, 255.0", "66.0, 61.0, 59.0, 255.0", "127.0, 0.0, 255.0, 255.0"],  // Modified (pink to purple)
    ["34.0, 31.0, 26.0, 255.0", "69.0, 66.0, 64.0, 255.0", "115.0, 38.0, 255.0, 255.0"],
    ["69.0, 66.0, 64.0, 255.0", "61.0, 59.0, 56.0, 255.0", "26.0, 255.0, 64.0, 255.0"],
    ["47.0, 41.0, 39.0, 255.0", "71.0, 69.0, 64.0, 255.0", "187.0, 30.0, 255.0, 255.0"],  // Modified (pink to purple)
    ["69.0, 66.0, 64.0, 255.0", "66.0, 64.0, 59.0, 255.0", "13.0, 255.0, 179.0, 255.0"],
    ["27.0, 21.0, 19.0, 255.0", "29.0, 26.0, 24.0, 255.0", "137.0, 10.0, 255.0, 255.0"],  // Modified (pink to purple)
    ["41.0, 39.0, 34.0, 255.0", "66.0, 61.0, 59.0, 255.0", "147.0, 20.0, 255.0, 255.0"],  // Modified (pink to purple)
                                           ["4.0, 31.0, 256.0, 255.0", "9.0, 16.0, 11.0, 255.0", "25.0,65.0, 255.0, 255.0"],
    ["69.0, 64.0, 61.0, 255.0", "64.0, 61.0, 59.0, 255.0", "51.0, 153.0, 255.0, 255.0"],
    ["71.0, 69.0, 66.0, 255.0", "69.0, 66.0, 64.0, 255.0", "255.0, 102.0, 0.0, 255.0"],
    ["34.0, 31.0, 29.0, 255.0", "71.0, 69.0, 66.0, 255.0", "187.0, 30.0, 255.0, 255.0"],
    ["31.0, 39.0, 26.0, 255.0", "46.0, 61.0, 59.0, 255.0", "147.0, 30.0, 255.0, 255.0"],  // Modified (pink to purple)
    ["69.0, 64.0, 61.0, 255.0", "64.0, 59.0, 56.0, 255.0", "255.0, 102.0, 0.0, 255.0"],
    ["34.0, 21.0, 29.0, 255.0", "71.0, 69.0, 66.0, 255.0", "187.0, 30.0, 255.0, 255.0"],
                                           ["16.0, 21.0, 59.0, 255.0", "11.0, 16.0, 64.0, 255.0", "127.0, 20.0, 255.0, 255.0"]
                                           ];
        
    constructor(address lib1, address lib2, address lib3, address dsp, address namesWrapper, address valuesWrapper, address shader, address colors) {
        libraryWrapper1 = lib1;
        libraryWrapper2 = lib2;
        libraryWrapper3 = lib3;
        dspWrapper = dsp;
        parameterNamesWrapper = namesWrapper;
        parameterValuesWrapper = valuesWrapper;
        shaderWrapper = shader;
        colorsWrapper = colors;
    }

    struct MetadataURIInfo {
        string contractURI;
    }

    /// @notice NFT metadata by contract
    mapping(address => MetadataURIInfo) public metadataBaseByContract;

    function getColorScheme(uint256 tokenId) public view returns (string[3] memory ) {
        /*
        string [][] memory colorSchemes;
        {
            colorSchemes= getColorSchemes();
        }
        */
        uint colorId = uint(uint(keccak256(abi.encodePacked(tokenId))) % colorSchemes.length);
        if (tokenId == 1) {
            colorId = 17;
        }
        return colorSchemes[colorId];
    }

    function generateColorScheme(uint256 tokenId) public view returns (string memory) {
        /*
        string [][] memory colorSchemes;
        {
            colorSchemes= getColorSchemes();
        }
        */
        uint colorId = uint(uint(keccak256(abi.encodePacked(tokenId))) % colorSchemes.length);
        if (tokenId == 1) {
            colorId = 17;
        }
        return string(
            abi.encodePacked(
                "const COLOR_ID = ", Conversion.uint2str(colorId), ";\n",
                "const color1 = \"", colorSchemes[colorId][0], "\";\n",
                "const color2 = \"", colorSchemes[colorId][1], "\";\n",
                "const color3 = \"", colorSchemes[colorId][2], "\";\n"));
    }

    function getColorSchemes() public view returns (string [][] memory) {
        return StringSplitter.split2D(ICompressed(colorsWrapper).uncompress(), ";", "/");
    }

    function getParameterNames() public view returns (string [] memory) {
        return StringSplitter.split(IData(parameterNamesWrapper).getData(), ",");
    }

    function getParameterValues() public view returns (string [][] memory) {
        return StringSplitter.split2D(IData(parameterValuesWrapper).getData(), ";", ",");
    }

    function lib(address x) external view returns (string memory) {
        return IZenLibrary(x).lib();
    }

    function tokenURI(uint256 tokenId) external view returns (string memory) {
        (string [] memory generated, string [] memory stats) = generateParameters(tokenId);

        string memory html;
        {
            html = string(abi.encodePacked(
                "data:text/html;base64,",
                Base64.encode(abi.encodePacked(generateHTML(tokenId, generated)))));
        }


        return string(abi.encodePacked(
          'data:application/json;base64,',
          Base64.encode(bytes(
            abi.encodePacked(
              "{",
              "\"description\": \"Bleep A by A.L.E.Z. Collection of 512 real-time audiovisual compositions, onchain. CCO license. \", ", 
              "\"image\": \"", SVG.generateSVG(tokenId, getColorScheme(tokenId), generated[13], generated[28]), "\",",
              getTraits(tokenId, stats), ",",
              "\"animation_url\": \"",
              html, "\"", 
              "}")))));
    }

    function generateFloatVariable(string memory name, uint256 tokenId) public view returns (string memory) {
        uint num = 20 + uint(uint(keccak256(abi.encodePacked(tokenId))) % 100);
        return string(abi.encodePacked(
            "const ", name, " = ", Conversion.uint2str(num), "/ 141.01;"));
    }

    function generateIntVariable(string memory name, uint256 tokenId, uint256 max) public view returns (string memory) {
        uint num = uint(uint(keccak256(abi.encodePacked(tokenId))) % max);
        return string(abi.encodePacked(
            "const ", name, " = \"", Conversion.uint2str(num), ".0\";"));
    }

    function getTraits(uint256 tokenId, string [] memory stats) public view returns (string memory) {
        string memory name;
        {
            name = Conversion.uint2str(tokenId);
        }

        string memory scaleName = scaleNames[tokenId == 1 ? 0 : tokenId == 2 ? 1 : tokenId % scales.length];
        string memory attr = string(abi.encodePacked(
            "\"name\": \"Bleep A", name, "\", ",
            "\"attributes\": [{\"trait_type\": \"scale\", \"value\": \"", scaleName, "\"},"));
            
        for (uint256 i=0; i < stats.length; i++) {
            attr = string(abi.encodePacked(attr, "{\"trait_type\": \"Gene #", Conversion.uint2str(i+1),"\", \"value\": \"", stats[i], "\"}"));
            if (i < stats.length - 1) {
                attr = string(abi.encodePacked(attr, ","));
            }
        }
        return string(abi.encodePacked(attr, "]"));
        /*
        for (uint256 i=0; i < generated.length; i++) {
            attr = string(abi.encodePacked(attr, "{\"trait_type\": \"", names[i] ,"\", \"value\": \"", generated[i], "\"}"));
            if (i < generated.length - 1) {
                attr = string(abi.encodePacked(attr, ","));
            }
        }
        return string(abi.encodePacked(attr, "]"));
        */
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
        return scales[tokenId == 1 ? 0 : tokenId == 2 ? 1 : tokenId % scales.length];
    }

    function generateDSPCall(uint256 tokenId, string [] memory generated) public view returns (string memory) {
        string memory scale = getScale(tokenId);
        string memory sig = string(abi.encodePacked("dsp(", scale, ","));

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


        if (tokenId >= 30 && tokenId % 10 != 5) {
            tokenId += 30;
        }
        if (tokenId >= 10 && tokenId % 10 == 8) {
            tokenId += 330;
        }

        /*
        if (tokenId >= 10 && tokenId % 10 == 0) {
            if (tokenId >= 20) {
                tokenId += 70;
            }
             tokenId += 40;
        } else if (tokenId >= 0 && tokenId % 10 == 5) {
            tokenId += 140;
        } else if (tokenId > 10) {
            if (tokenId % 10 == 4 || tokenId % 10 == 6) {
                tokenId += 200;
            }
            tokenId += 200;
        }
        if (tokenId % 100 > 90 && tokenId % 100 < 100) {
            tokenId += 399;
        }
        if (tokenId > 10 && ((tokenId % 2 == 0 && tokenId % 10 != 8) || (tokenId % 2 == 1 && (tokenId % 10 >= 7 || tokenId % 10 == 3)))) {
            tokenId += 140;
        }
        if (tokenId > 20 && (tokenId % 10 == 8)) {
            tokenId += 130;
        }
        if (tokenId > 10 && (tokenId % 10 == 5)) {
            tokenId += 70;
        }
        */
        uint latchBase = (tokenId < 10 ? 13 : 24) - (tokenId < 100 ? (tokenId / 8) : 12);
        //uint latchBase = (tokenId < 10 ? 13 : 24) - (tokenId < 200 ? (tokenId / 16) : 12);
        if (tokenId >= 10) {
            latchBase /= 3;
        }


        uint [] memory counts = new uint[](parameterValues.length);
        uint count = 0;
        for (uint i=0; i < parameterNames.length; i++) {
            // Use the pseudorandom number to select a preset for this parameter
            if ( i % latchedWidth == 0) {
                latched = tokenId <= 4 ? tokenId - 1 : (uint(keccak256(abi.encodePacked(tokenId, '-', i))) % parameterValues.length);

                // 8 was good but lets try 3 to go even crazier good one bwain
                latchedWidth = (latchBase + (uint(keccak256(abi.encodePacked(tokenId, '-', i)))) % 15);

                //latchedWidth = (latchBase + (uint(keccak256(abi.encodePacked(tokenId, '-', i)))) % (tokenId > 10 ? 8 : 15));
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

    function generateHTML(uint256 tokenId, string [] memory generated) public view returns (string memory) {
        bytes memory part1;
        {
            part1 = abi.encodePacked(
            '<!DOCTYPE html><html lang="en"><head>',
            '<meta charset="UTF-8">',
            '<meta name="viewport" content="width=device-width, initial-scale=1.0">',
            '<style>#aw { z-index: 31; display: none; position: fixed; top: 50%; left: 50%; transform: translate(-50%, -50%); padding: 5px; width: 400px; height: 200px; background: white; text-align: center; }</style>'
            '<title>Music Generator</title>'
            '</head>'
            '<body style="background-color: white; display: flex; margin: 0">'
            '<div id="aw">This marketplace does not support AudioWorklet yet. Visit <a target="_blank" href="https://bleep.fun">bleep.fun</a> or <a href="https://opensea.io">Opensea</a> for the full experience.</div>',
            '<div id="playButton" style="position: absolute; z-index: 30; width: 0; height: 0; border-top: 30px solid transparent; border-bottom: 30px solid transparent; border-left: 60px solid #E2E5DE; margin: auto; position: absolute; top: 0; right: 0; bottom: 0; left: 0;"></div>'
            '<script>',
            IData(libraryWrapper1).getData(),
            IData(libraryWrapper2).getData(),
            IData(libraryWrapper3).getData(),
            ';let isPlaying = false;'
            ';let workletNode, gainNode;',
            generateSignature(),
            '{ \n',
                    'let history = window.ZEN_LIB.history;\n',
                                                       IData(dspWrapper).getData()
                                                       );

        }

                string memory bit = bytes(generated[46])[0] == '1' ? 'bitA' : 'bit';
        bytes memory part2;
            
        {
            part2 = abi.encodePacked(
            '\n}\n'
            'let useC = false;\n',
            'window.addEventListener("message", (e) => { if (e.data === "useC") { useC = true; }});\n',
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
            generateDSPCall(tokenId, generated),
            ';\nlet ctxt = new (window.AudioContext || window.webkitAudioContext)({sampleRate:44100});\n'
            'if (!new (window.AudioContext || window.webkitAudioContext)().audioWorklet) document.getElementById("aw").style.display = "block";\n'
            'if (!gainNode) gainNode  = ctxt.createGain(); \n'
            'if (ctxt.state === "suspended") {\n ctxt.resume();\n}\n'
            'if (!workletNode) {\n'
                'let zenGraph = useC ? zenC(x) : zen(x);\n'
                'createWorklet(ctxt, zenGraph).then(z => {\n'
                        'workletNode = z.workletNode;\n'
                        'const compressor = ctxt.createDynamicsCompressor();\n'
                        'compressor.threshold.value = -8;  \n'
                         'compressor.knee.value = 2;  \n'
                          'compressor.ratio.value = 8;  \n'
'compressor.attack.value = 0.001;  \n'
'compressor.release.value = 0.1;\n'
                                    'gainNode.connect(compressor);\n'
                        'compressor.connect(ctxt.destination);\n'
                        'z.workletNode.connect(gainNode);\n'
                             'workletNode.port.onmessage = (e) => {\n'
                            'let {type, body} = e.data\n'
'if (type === "phase") {\n'
 '    update("kickEnv", body);\n'
'}\n'
'if (type === "', bit,'") {\n',
'    updateBit(body);\n'
'}\n'
'if (type === "wasm-ready" && useC) {\n'
'initMemory(zenGraph.context, workletNode);\n'
'workletNode.port.postMessage({ type: "ready" });\n'
                                                     '}\n'
                                'if (type === "kickEnv") {\n'
                                    'update("phase", body*0.5);\n'
                                                                   '}}});'
            '}\n'
                  'gainNode.gain.setValueAtTime(isPlaying ? 5.3 : 0, ctxt.currentTime);\n');
            }

            bytes memory part3;
            {
                part3 = abi.encodePacked(
                    '}\n', // end of generate music func
                    'const gridSize = (\"', Conversion.uint2str(uint(2)**(uint(4)+uint(uint(keccak256(abi.encodePacked(tokenId))) % 3))), '.000\");\n',
                                                                                                                                                     generateFloatVariable("crossSize", tokenId),
                                                                                                                                                     generateIntVariable("yRate", tokenId, 100),
                                                                                                                                                     generateColorScheme(tokenId),
                                                                                                                                                     IData(shaderWrapper).getData(),
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
