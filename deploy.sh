source .env
forge script script/DeployZen.s.sol --rpc-url $RPC_ENDPOINT --private-key $PRIVATE_KEY -vvv --broadcast --ffi --etherscan-api-key $ETHERSCAN_KEY --verify 
    
