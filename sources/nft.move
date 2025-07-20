/// Module: nft
module nft::nft;

use std::string;
use sui::event;
use sui::object::ID;
use sui::transfer;
use sui::tx_context::TxContext;
use sui::url::{Self, Url};

public struct TestNFT has key, store {
    id: UID,
    name: string::String,
    description: string::String,
    image_url: Url,
}

public struct TestNFTMinted has copy, drop {
    object_id: ID,
    creator: address,
    name: string::String,
}

public fun name(nft: &TestNFT): &string::String {
    &nft.name
}

public fun mint_nft(
    name: vector<u8>,
    description: vector<u8>,
    url: vector<u8>,
    ctx: &mut TxContext,
) {
    let sender = ctx.sender();
    let nft = TestNFT {
        id: object::new(ctx),
        name: string::utf8(name),
        description: string::utf8(description),
        image_url: url::new_unsafe_from_bytes(url),
    };

    event::emit(TestNFTMinted {
        object_id: object::id(&nft),
        creator: sender,
        name: nft.name,
    });

    transfer::public_transfer(nft, sender);
}

public fun transfer(nft: TestNFT, recipient: address, _: &mut TxContext) {
    transfer::public_transfer(nft, recipient);
}
