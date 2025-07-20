# Sui Move NFT Module

This guide explains how to publish, mint, and transfer NFTs using the Move module in `sources/nft.move`.

## Prerequisites

- **Sui CLI Installed:** Follow the [Sui installation guide](https://docs.sui.io/build/install-sui) if needed.
- **Sui Wallet Configured:** Set up a wallet with an active address and enough SUI for gas fees.

```bash
    sui client active-address
```
- Module Published: Publish the nft::nft module and note the package ID.
- Network: Connect to the correct network (e.g., devnet):

```bash
    sui client switch --network devnet
```

- Check your devnet balance to ensure its enough for the deployment if not, request from https://faucet.sui.io/

```bash
    sui client balance
```


## Steps to Mint and Send an NFT
##### 1. Publish the Module
Save the Move code in sources/nft.move and publish:

```bash
sui client publish 
```

#### Note the package ID from the output.

##### 2. Mint the NFT
- Call the mint_nft entry function to create and transfer an NFT:

```bash
sui client call \
  --package <PACKAGE_ID> \
  --module nft \
  --function mint_nft \
  --args "MyNFT" "A cool NFT" "https://example.com/nft" \
  --gas-budget 10000000
```

- Arguments: name, description, and url as strings.
- After execution, the NFT is minted and transferred to your wallet.


##### 3. Verify the NFT
Check your wallet for the NFT:

```bash
sui client objects --address <YOUR_ADDRESS>
```
Look for the TestNFT object with the object ID from the minting transaction.

##### 4. Transfer the NFT
Send the NFT to another address:

```bash
sui client call \
  --package <PACKAGE_ID> \
  --module nft \
  --function transfer \
  --args <NFT_OBJECT_ID> <RECIPIENT_ADDRESS> \
  --gas-budget 10000000
```
- First argument: NFT object ID.
- Second argument: recipient's address.


##### 5. Verify the Transfer
Confirm the NFT is in the recipient’s wallet:

```bash
sui client objects --address <RECIPIENT_ADDRESS>
```

## Example Commands
Assuming:

- Package ID: 0x123...
- Your address: 0x456...
- Recipient address: 0x789...
- NFT object ID: 0xabc...

#### Minting:

```bash
sui client call \
  --package 0x123... \
  --module nft \
  --function mint_nft \
  --args "MyNFT" "A cool NFT" "https://example.com/nft" \
  --gas-budget 10000000
```

#### Transferring:

```bash
sui client call \
  --package 0x123... \
  --module nft \
  --function transfer \
  --args 0xabc... 0x789... \
  --gas-budget 10000000
```

### Notes
- Gas Fees: Ensure your wallet has enough SUI.
- No Frontend: All interactions use the Sui CLI.
- Alternative Methods: Sui Rust/TypeScript SDKs are available, but CLI is simplest.
- Event Emission: The mint_nft function emits a TestNFTMinted event for verification.