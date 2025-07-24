// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "erc721a/contracts/ERC721A.sol";
import "@openzeppelin/contracts/token/common/ERC2981.sol";

contract DobieCoinNFT is ERC721A, ERC2981, Ownable {
    using Strings for uint256;

    uint256 public constant MAX_SUPPLY = 500;
    uint256 public constant MAX_PER_WALLET = 3;
    uint256 public constant MINT_PRICE = 0.1 ether;

    string private baseTokenURI;
    string private placeholderURI;
    bool public revealed = false;

    mapping(address => uint256) public mintedWallets;

    constructor(string memory _placeholderURI) ERC721A("DobieCoinNFT", "DOBIE") {
        placeholderURI = _placeholderURI;
        _setDefaultRoyalty(msg.sender, 500); // 5% royalties
    }

    function mint(uint256 quantity) external payable {
        require(totalSupply() + quantity <= MAX_SUPPLY, "Sold out");
        require(mintedWallets[msg.sender] + quantity <= MAX_PER_WALLET, "Max 3 per wallet");
        require(msg.value >= quantity * MINT_PRICE, "Insufficient payment");

        mintedWallets[msg.sender] += quantity;
        _safeMint(msg.sender, quantity);
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        require(_exists(tokenId), "Token does not exist");
        if (!revealed) {
            return placeholderURI;
        }
        return string(abi.encodePacked(baseTokenURI, tokenId.toString(), ".json"));
    }

    function setBaseURI(string memory _uri) external onlyOwner {
        baseTokenURI = _uri;
    }

    function setPlaceholderURI(string memory _uri) external onlyOwner {
        placeholderURI = _uri;
    }

    function reveal() external onlyOwner {
        revealed = true;
    }

    function withdraw() external onlyOwner {
        payable(owner()).transfer(address(this).balance);
    }

    // Royalties
    function supportsInterface(bytes4 interfaceId) public view virtual override(ERC721A, ERC2981) returns (bool) {
        return super.supportsInterface(interfaceId);
    }
}
