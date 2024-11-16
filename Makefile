-include .env

.PHONY: update build clean remove install deploy deploy-sepolia test zktest all snapshot

build:; forge build

clean:; forge clean

remove :; rm -rf .gitmodules && rm -rf .git/modules/* && rm -rf lib && touch .gitmodules && git add . && git commit -m "modules"

update:; forge update

install :; forge install && forge install smartcontractkit/chainlink-brownie-contracts@0.6.1 --no-commit && forge install Cyfrin/foundry-devops --no-commit

test :; forge test

snapshot:; forge snapshot

format:; forge fmt

zktest :; foundryup-zksync && forge test --zksync && foundryup

deploy:; forge script script/DeployFundMe.s.sol:DeployFundMe --broadcast --rpc-url http://localhost:8545  --private-key $(DEFAULT_ANVIL_KEY)   -vvvv 

all: clean remove install update build

deploy-sepolia:
	forge script script/DeployFundMe.s.sol:DeployFundMe --rpc-url $(SEPOLIA_RPC_URL) --private-key $(SEPOLIA_PRIVATE_KEY) --broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY) -vvvv