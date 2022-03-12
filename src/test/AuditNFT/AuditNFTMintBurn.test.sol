// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

import {AuditNFT, TokenAlreadyExist} from "../../AuditNFT.sol";
import {AuditLibrary} from "../../libraries/AuditLibrary.sol";

import {DSTest} from "ds-test/test.sol";
import {Utilities} from "../utils/Utilities.sol";
import {console} from "../utils/Console.sol";
import {Vm} from "forge-std/Vm.sol";

contract TestAuditNFTBasics is DSTest {
    using AuditLibrary for AuditLibrary.AuditSlot;

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

    function testMint() public {
        // owner should be able to mint the token
        AuditLibrary.AuditSlot memory slot = AuditLibrary.AuditSlot({
            auditFirmId: 1,
            nonuce: 0,
            totalEngineeringDay: 10,
            startTimestamp: 1669849200,
            endTimestamp: 1672441200
        });
        uint256 id = slot.toTokenId();
        uint256 balanceBefore = nft.balanceOf(address(this), id);

        assertEq(balanceBefore, 0);

        nft.mintAuditToken(slot, "0x00");

        uint256 balanceAfter = nft.balanceOf(address(this), id);
        assertEq(balanceAfter, 10);

        // if owner trying to increase the supply for a existing token, it will revert

        vm.expectRevert(abi.encodeWithSelector(TokenAlreadyExist.selector));
        nft.mintAuditToken(slot, "0x00");
    }

    function testFailedMint() public {
        vm.prank(users[1]);
        AuditLibrary.AuditSlot memory slot = AuditLibrary.AuditSlot({
            auditFirmId: 1,
            nonuce: 0,
            totalEngineeringDay: 10,
            startTimestamp: 1669849200,
            endTimestamp: 1672441200
        });

        nft.mintAuditToken(slot, "0x00");
    }

    /// @dev make sure we can receive the token
    function onERC1155Received(
        address,
        address,
        uint256,
        uint256,
        bytes calldata
    ) external returns (bytes4) {
        return this.onERC1155Received.selector;
    }
}
