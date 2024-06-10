// Create a variable to hold your NFTs
let nfts = [];

// This function will take in some values as parameters, create an
// NFT object using the parameters passed to it for its metadata, 
// and store it in the variable above.
function mintNFT(name, artist, owner, value) {
    const nft = {
        name: name,
        artist: artist,
        owner: owner,
        value: value
    };
    nfts.push(nft);
}

// Create a "loop" that will go through an "array" of NFT's
// and print their metadata with console.log()
function listNFTs() {
    for (let i = 0; i < nfts.length; i++) {
        console.log(`NFT #${i + 1}`);
        console.log(`Name: ${nfts[i].name}`);
        console.log(`Artist: ${nfts[i].artist}`);
        console.log(`Owner: ${nfts[i].owner}`);
        console.log(`Value: ${nfts[i].value}`);
        console.log('-------------------');
    }
}

// Print the total number of NFTs we have minted to the console
function getTotalSupply() {
    return nfts.length;
}

// Call your functions below this line
mintNFT("CryptoPunk", "Larva Labs", "Alice", "100 ETH");
mintNFT("Bored Ape", "Yuga Labs", "Bob", "150 ETH");
mintNFT("Hashmask", "Suum Cuique Labs", "Charlie", "80 ETH");

listNFTs();
console.log(`Total NFTs minted: ${getTotalSupply()}`);
