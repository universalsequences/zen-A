source .env
forge script script/DeployZen.s.sol --chain-id 999 --rpc-url $RPC_ENDPOINT --private-key $PRIVATE_KEY -vvv --broadcast --ffi --etherscan-api-key $ETHERSCAN_KEY --verify 
    
