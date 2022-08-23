// SPDX-License-Identifier: MIT

// Compiled 13 Solidity files successfully
// Contract deployed to: 0x5FbDB2315678afecb367f032d93F642f64180aa3
// dheeraj@Dheeraj:~/road-to-web3-wk3/ChainBattles$ npx hardhat run scripts/deploy.js --network mumbai
// Contract deployed to: 0x8412FFBe852cd3B0FB3F557147Bd68C65c02f957
// dheeraj@Dheeraj:~/road-to-web3-wk3/ChainBattles$ npx hardhat verify --network mumbai 0x8412FFBe852cd3B0FB3F557147Bd68C65c02f957
// Nothing to compile
// Warning: Function state mutability can be restricted to view
//   --> contracts/ChainBattles.sol:19:5:
//    |
// 19 |     function generateCharacter(uint256 tokenId) public returns (string memory) {
//    |     ^ (Relevant source part starts here and spans across multiple lines).

// Successfully submitted source code for contract
// contracts/ChainBattles.sol:ChainBattles at 0x8412FFBe852cd3B0FB3F557147Bd68C65c02f957
// for verification on the block explorer. Waiting for verification result...

// Successfully verified contract ChainBattles on Etherscan.
// https://mumbai.polygonscan.com/address/0x8412FFBe852cd3B0FB3F557147Bd68C65c02f957#code
// dheeraj@Dheeraj:~/road-to-web3-wk3/ChainBattles$

// ////////////////////////

// Contract deployed to: 0x8412FFBe852cd3B0FB3F557147Bd68C65c02f957
// ///////
// Contract which has implemented the strct of nft as level
// Contract deployed to: 0xFf515f0c3B11fdd0089d2244ff3e82db6529ffC4

// Contract deployed to(v1.0) : 0x240e5a8a1353f3e08Be5BcD31aC756F4dfF7C18a
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/Base64.sol";

contract ChainBattles is ERC721URIStorage {
    using Strings for uint256;
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    mapping(uint256 => uint256) public tokenIdToLevels;
    struct NftLevels {
        uint256 Level;
        uint256 Speed;
        uint256 Strength;
        uint256 Life;
    }
    NftLevels nftLevels;

    constructor() ERC721("Chain Battles", "CBTLS") {}

    function generateCharacter(
        uint256 Level,
        uint256 Speed,
        uint256 Strength,
        uint256 Life
    ) public returns (string memory) {
        bytes memory svg = abi.encodePacked(
            '<svg xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMinYMin meet" viewBox="0 0 350 350">',
            "<style>.base { fill: white; font-family: serif; font-size: 14px; }</style>",
            '<rect width="100%" height="100%" fill="black" />',
            '<text x="50%" y="40%" class="base" dominant-baseline="middle" text-anchor="middle">',
            "Warrior",
            "</text>",
            '<text x="50%" y="50%" class="base" dominant-baseline="middle" text-anchor="middle">',
            "Levels: ",
            getLevels(Level, Speed, Strength, Life),
            "Speed",
            getSpeed(Level, Speed, Strength, Life),
            "Strength",
            getStrength(Level, Speed, Strength, Life),
            "Life",
            getLife(Level, Speed, Strength, Life),
            "</text>",
            "</svg>"
        );

        return
            string(
                abi.encodePacked(
                    "data:image/svg+xml;base64,",
                    Base64.encode(svg)
                )
            );
    }

    function getLevels(
        uint256 Level,
        uint256 Speed,
        uint256 Strength,
        uint256 Life
    ) public returns (string memory) {
        nftLevels = NftLevels(Level, Speed, Strength, Life);
        return nftLevels.Level.toString();
    }

    function getSpeed(
        uint256 Level,
        uint256 Speed,
        uint256 Strength,
        uint256 Life
    ) public returns (string memory) {
        nftLevels = NftLevels(Level, Speed, Strength, Life);
        return nftLevels.Speed.toString();
    }

    function getStrength(
        uint256 Level,
        uint256 Speed,
        uint256 Strength,
        uint256 Life
    ) public returns (string memory) {
        nftLevels = NftLevels(Level, Speed, Strength, Life);
        return nftLevels.Strength.toString();
    }

    function getLife(
        uint256 Level,
        uint256 Speed,
        uint256 Strength,
        uint256 Life
    ) public returns (string memory) {
        nftLevels = NftLevels(Level, Speed, Strength, Life);
        return nftLevels.Life.toString();
    }

    function getTokenURI(
        uint256 Level,
        uint256 Speed,
        uint256 Strength,
        uint256 Life
    ) public returns (string memory) {
        bytes memory dataURI = abi.encodePacked(
            "{",
            '"name": "Chain Battles #',
            Level.toString(),
            '",',
            '"description": "Battles on chain",',
            '"image": "',
            generateCharacter(Level, Speed, Strength, Life),
            '"',
            "}"
        );
        return
            string(
                abi.encodePacked(
                    "data:application/json;base64,",
                    Base64.encode(dataURI)
                )
            );
    }

    function mint() public {
        _tokenIds.increment();
        uint256 Level = _tokenIds.current();
        uint256 Speed = _tokenIds.current();
        uint256 Strength = _tokenIds.current();
        uint256 Life = _tokenIds.current();
        _safeMint(msg.sender, Level);
        // tokenIdToLevels[newItemId] = 0;
        nftLevels.Level = 0;
        _setTokenURI(Level, getTokenURI(Level, Speed, Strength, Life));
    }

    function train(
        uint256 Level,
        uint256 Speed,
        uint256 Strength,
        uint256 Life
    ) public {
        require(_exists(Level), "Please use an existing Token");
        require(
            ownerOf(Level) == msg.sender,
            "You must own this NFT to train it!"
        );
        uint256 currentLevel = nftLevels.Level;
        uint256 currentSpeed = nftLevels.Speed;
        uint256 currentStrength = nftLevels.Strength;
        uint256 currentLife = nftLevels.Life;
        nftLevels.Level = currentLevel = 1;
        nftLevels.Speed = currentSpeed = 1;
        nftLevels.Strength = currentStrength = 1;
        nftLevels.Life = currentLife = 1;

        _setTokenURI(Level, getTokenURI(Level, Speed, Strength, Life));
    }
}
