// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "../lib/forge-std/src/Test.sol";
import "../src/Spacebear.sol";

contract SpacebearTest is Test {
    Spacebear bear;

    function setUp() public {
        bear = new Spacebear();
    }

    function testNameIsSpacebear() public {
        assertEq(bear.name(), "Spacebear");
    }

    function testMinting() public {
        bear.safeMint(msg.sender);
        assertEq(bear.ownerOf(0), msg.sender);
        assertEq(bear.tokenURI(0), "https://ethereum-blockchain-developer.com/2022-06-nft-truffle-hardhat-foundry/nftdata/spacebear_1.json");
    }

    function testNftCreationWrongOwner() public {
        address purchaser = address(0x1);
        vm.startPrank(purchaser);
        vm.expectRevert("Ownable: caller is not the owner");
        bear.safeMint(purchaser);
        vm.stopPrank();
    }

    function testNftBuyToken() public {
        address purchaser = address(0x2);
        vm.startPrank(purchaser);
        bear.buyToken();
        vm.stopPrank();
        assertEq(bear.ownerOf(0), purchaser);
    }
}