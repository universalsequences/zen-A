
pragma solidity ^0.8.20;
import "./InflateLib.sol";

contract CompressedShader {
    bytes public data;

    constructor() {
        data = hex"ed1b6b53dbc6f6bb7fc596e91409842dc936e0eba8770c98c4738130c634b793e9b8b2b5169aca922bc90f39e5bfdf73f6a1876d08a4776eef34491bd0ee79ee79ed9176531987419c904ebfdff979f8a177317867d5cd76c5a70999cf1c3ba1fc39893cd7a5519f060e8dda95c93c18275e1890c9dcf7efc611a5010729633b58d871cfd1c824b2ddbb68ac7eaad46a5c0887594e389e4f6990545d9a747d8a8f6769cfc948d57665373ec801850489b2cfc1fb88ce9eaa7192fab4baf49ce4c1da37747db1dcdf803d50cf7d4838f00180a01a793fc395d8be9f6a2486a57a494c180f62070ee114954c8751e8a4557b3683d59e3f78bed43a57828b1783b1ef01d107c6ed80981992d0a384f58ecd71b48a44b41da7bb00e09517273400fbee2fe9c8f5c13e095d257e1827fb6069e10d85222a189cfdaece22f6fb824eecb99f286a1b163b78f062e27b0145e3c2e2fc1911682479a0c4e1b8c4e6de0d27240913340d71bd8517b8101304e611f5031dbdbd2242912af3580816f64357d92fc1084a4445c1468fa0acedc75465a67f91c532b4cfd98cc78ceb4b0c88ae73ae8130dabefac71f640790ae6634f2d0bbb67f24307968fc44234021f1830da14de2701e8da990b3001044b7f56bc54e203946f384c2dcd824f67016c61e9aaf5d59849e43a6b61728e014d71fde0a8805980d25c7d4885ed535625475b451e5572efd3c9cce3c9f4af1d2cb79f28d39c21d832b7134d64892ce28c8e23a7242cbf545e6084486d3067daa1ce18ead4be103c801c85906dd60cf7e01c49b28df01142cc821b776644f6992a168e083eaf9fbebdbde55777837e80ceeef54a11206088da230528a0c7ac124bc82b01112b8708742d9d9921dd1641e052480aa838612430ec6096636b65608ebd005c576998d21dc72b8b2882126e3cc66822c379ac4e36a81b3edf183504be06a64113f079d0828a4dd6f929b0096cc2960b93d330e00bfeaddfceb33d614f4d29c5244d19edbe2775b54c099490bf1cee3a91c17221198923f75fb83eebf8777ef3a17dd7e56c6d946b08b54ec108cf4b2df797bddbd196c124b7f6c382dd3462bb0cf8822ea084c2b5b89d0855267648fa51fac1cb34d6ab55d4ee774f35ba89297e898ab706cb31ce646bf0fbc49184de5acb2214023fbf3e14cd2b2bab211870c309a4f2614fda8f1ad4713fb4e1696931c2b0fcd2229f7f2c80b9c324334ec75f7ecfef2b2dbd78a6c5015ce1babe03ca239df019f28f094333004070feefbdda179a1494a8e0783ded476a979b189a6330ff7df9e7536965706c1c3fdcd5defed4df76278f6f3a0abb1a8443d39f72c31bc4d0185e1877ee77678c76bd055e7fa7638783fec5ebced663abe9ccbe0cf72b9eedd0c2f7b5703b43c4cdf743bfdeedde0953c3a6f77f3402605770a0f71e3977cceaaf1d5fbfeb0331874cedf6192e92511054f824304eb67bc2ebcf2827093fe1355e55331fe3299e4b150662623c3da9d17c566211b892cc9b27b647e1135ae651eefa88eb89fdcb15698b834046745298174676def51ccfa5ef2fbdc7684fccd043ddbcccdb3cc4ebce19686ca5212f1d8f3859dd8db78015d924b3fb493bad989223b553e1e191ac1bfe29778c4ff7f51999771cfe89d0f2ffa9d0f79cacbc663a39875582b93d5b26cffd9cb5b953dae240dec914f797fc4a9b83e9b8c39f6a280771b7a01dbdc36303562f28de0ea7d6720da44561f5844b29790f13c8aa04bbb3cb3204cf87b092bad38c6a61927265e1427ccfb5612cd69e15525e22f28ec7d845c44f672db8b00e02f3dacc39df3d2ce1c9e407f58e13051f15958e5166291b5070fc6640fab5ce084cbaa1740cbce7a5958c373d43c127792bf9341cae9454ec6c040c4277ff182463db70f3080f679632b7a49c2661caae59da29c1ff9a6f9bac8c6b78a05ddae2ac667371aeee66abedfb096067cc8a22e66e8fd5ee7e62d6b39fbbd5b16390d44dc65b692d5d0d52208d06cd26ae43505eea546f87356c8bd53da78459c1a9eb2dda5401d7895b56447309d599934a8ae59e27147b42b22ef109155efd2f7012b129f099eceb4972a24778e52ba70f6b28c6b9b81cef7132c06716247c90052d7c2c20925157a1aac7338855539ab0db3088a5287394624685cccd0ac0d0be65309b75ed0b477ce07bd9fbac3fb9bdee5fbfef51d4a846e1d35f32cbd4d3cf2a6c811260e0f3351c2abd8cdcbea5cd42f97e3b177c6c78a281a6100fb83432c45b57e249f2a315f6d384f1431e3059ee89d15fe466ee8ba9efb1ede6413d8109efa48b337f3edf48ce1eca9ccc89e036b91d2b7be57ecc18bfaf8b73d4d08777112fc703d8fbd3193af3e433b0da1ea4cc305cde8f16dc98b6f41072f70c1565c5bf175279cd9632f492d43c60d2cea91e93804250f0f3da7fd24c10e3b4d142023df59162c114449968fbb79e8455b3eaa859e2637b865c76930cebfd714db7b977f4d80c41a7b31c6e4943ade7c3a2313dcefb166c9fd083f1ec0bbbf1f46c3c6c9a9d96a9d9cb4eafa69e3b86eb44ecc49e3b4a9eb0d3a328d5388b1dd74ad915eaf9fd48f5bf4b4ded01dfbb4a59bc7746c3886d9b26db3fe145dbdd9386e369d89d330f4c6d868b54c789a0049a341c7adb10d74922ab6a7339f46e685ecf3863ef8b580c0d645660f764cb7667f8398e9068bad798f6d4b5bd36cf3dd9ae59bead674389980b3878b9dba165ed6b0eba8c0daeb641a3ae6694b61cfab2c12c88a1c214bc8e81539508caa4e6a04f0aabaaa1ef0070c02663dce61d850d8e8753c886432a3d1740e256c9347c65c515607f506d01ee297a483959ac94fec14dcd70b1677bf47096710e50c8cea49cb3c6d982da3a1eb46b3053ae9d5d3260448e3c4d45bcdbad1200724929ad4a139732837479273490ef03f85fd7f5cd58f8c26d344171fb584bb69e47b01a7bd055af6e0e996303137c5ad0aadab67c8494f2787188475b40f7ecee03ae81604c338016cd8010c6ba283da19164c594ccb89ce091ac45bf1cf6e9e5e5d217bf6337b4689698690a66c364d33e2b56ec1fc1afe00646d5800c541c63bb5a47be46f6fa51e024f64bc4a752b9f4e6139c08f038c2d802165ba2b9009a459609cb085b9a95c39b716a0a9450c15bdd7cc7818c8c3d8e2616cf03076f24015381e4a693376729ceb09b66186031220b44731c3164f29ca8b01058afa4c015c8d0864e94be4606c7330320e06e360480e469903c82247168a80453214f63195ab800cdb68b29d286986025c0c8e626c70310a5c76a3a4190a8f4c9799a38e4680e80221f873adb318738d1c963258ca601026ae9983d60cb466a03592d573d892c1960cb604b28604194c1afbb9e611ed367358ca602983a1b4e31cb466a03503316927396cc9604b065b4a7f055034756bbba8284e0891a16b2efa9c3d9bb02cf96c68ae219feb9a5b57d5223fe3497e0d58a3a43b06c5e57353739bf2f944734f183f175c6c7105ab2bf099990f53181af9700dc37a3e5c026d430e0d467b9c0f91b6990f91f6241f2ee53ad6d6d45b954cc14bd284d599097a1b7faed5dc2602c1d84210f62b3130b618d4cb0c0a08aa5634e10e3d8c029be62e3d8c5c8fe35d7a14199cecd2c3e07a9009fcce7a79b30a3e216827fc1bac011f7eacb5098625117329ce2dc5dca4cab7b2f2790a3b6d09e60b6875a1571fc29eed9e432d73aaabb48630a5fc2555ad996c27aabca27de245e9fb4f0cdb80a68e545ed14495a8cd4719ec2feba44ac475416c9291ed0cd992a1561f6cacfa68e7aaf9c32183b17a25fb1f610b93ccbc15da10383e6737860ab456cee9fb4f691f7af9c703d6c4d5b2cf69995ea03a4b0825c9be4e2a850e4bd5a065010ff2ad071ae74314c055e57f0a74c52e12083912dfbd94c28330d021e11cd59a62f2870330a61b79ce9db7a68f1095d5483dfc3242777b0eb067e1b238a91141cecef610052502a1983e124b861945010f4088c3637d8b8867c4cbc2b588fbb9e0d45e1887dad7e2075c28b61ba80beb709e53e65036b20a6b65bf74e1da17ae5be3af4d2a02f5aad964ebdac11f56077d093279a3602d89c238e660883a8c156cf31b1a17f9d578fa903fc0ebc2576b029812afd8ec5d4f0756d226383a849f86c08397b0afa918ffdfe5b52609d51f7ef89b1528f75b81fa56a0be15a8bf4d8152ff492adc4bff2015b60eed9b77fe22ef30f71c8a1caae147e1832d87a10f4f8f0d555e3ac49392f249dbd66da6f2d1dba3b575ff57decacdefffb6ffe273f38a8d878cec04f0de0b92537e51e1f4a0b1eb388ee1567d1ab878a0c0cfe3d8dc47ef17cb6c36f961270f5f7953253fadd538bd56bc4ecd4f606b3519fe4f119980689e8af3da5a8ddc844b02aaedc7044f8449821777e58d99242436d938bc205e40d2701e89db9015316d3c714f2db7613119f79e3fa8d7d91de2fb98669a801209315e764dccd83cae962ab23b1e783999fa3e3f8ee7375e6199f34d593ade260ac4e1a5880d6229813da51a59d8fe9cf2d3bb67a286e3f288e114e89f9ceb23307eea48723fa23124dcbe3c8ffc6f5efa260515f8f72e79145cbac200ab75fde22277c49fb4b846721b17dcc82fd53cb677f167ecf94562a753e296311356d5c850406022c9d07070339f720dc1abef28305d52bc0e8ef78098834b2e0de6d311f7b69ddf2a8f133b48b663b128f115d7135f723ff1eafeba77d3b939ef6ea6ef0e84edab8ab9bd44fe9ef1aca5c5a465b12dd255a4c1ce8cc80cbc61521e9b58b0989fc53fcd10bee623e9efed8ba6c530017fdb4f5d35fd1f5d072d5873e79dd067ad8dfa7fc18dceafe15ea83c8de5bed82e23b7d82260c5645957ac23ca1e6b1ff63491913cdc6ab5c77699c319e4aca5c056ca8931ea465e125b1f7f296ea827b8a1fe6811dc588f8ed40c8f93921f1483bc79433c6c1a0de817f57605995467f3f84119b1e47e7cd9f62caead7889850c3e5edbc94395b74f5eada1824ed9fe8dd2ff4960170779867982124af79694dc7cc88a675b96459fdd51b004c81d45aae53f7f5bbcc481ff630049412ccb224746e9e20980510803ed1b937db5503c72ca7c572be37b257c6f073e94ad8ee39010ea54c49613133b26013481d4c140fa0f";
    }

    function uncompress()
        external
        view
        returns (string memory)
    {
        (InflateLib.ErrorCode err, bytes memory mem) = InflateLib.puff(data, 13869);

        if (err == InflateLib.ErrorCode.ERR_NONE) {
            return string(mem);
        }
        return "";
    }
}
