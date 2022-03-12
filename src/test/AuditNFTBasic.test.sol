// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

import {AuditNFT} from "../AuditNFT.sol";

import {DSTest} from "ds-test/test.sol";
import {Utilities} from "./utils/Utilities.sol";
import {console} from "./utils/Console.sol";
import {Vm} from "forge-std/Vm.sol";

contract TestAuditNFTBasics is DSTest {
    Vm internal immutable vm = Vm(HEVM_ADDRESS);

    AuditNFT private nft;

    Utilities internal utils;
    address payable[] internal users;

    constructor() {
        // deploy AuditNFT and act as owner
        nft = new AuditNFT();
    }

    function setUp() public {
        utils = new Utilities();
        users = utils.createUsers(5);
    }

    function testSetHost() public {
        string memory newHost = "https://ourtokeninfo/";
        nft.setHost(newHost);

        string memory hostAfter = nft.host();
        assertEq(newHost, hostAfter);

        string memory uri = nft.uri(1);
        assertEq(uri, "https://ourtokeninfo/1");
    }

    function testFailNonOwnerSetHost() public {
        vm.prank(users[1]);
        nft.setHost("https://malicious/");
    }
}
