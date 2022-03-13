// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

import {AuditNFT, TokenAlreadyExist} from "../../AuditNFT.sol";
import {AuditLibrary} from "../../libraries/AuditLibrary.sol";

import {DSTest} from "ds-test/test.sol";
import {Utilities} from "../utils/Utilities.sol";
import {console} from "../utils/Console.sol";
import {Vm} from "forge-std/Vm.sol";

contract TestAuditLibrary is DSTest {
    using AuditLibrary for AuditLibrary.AuditSlot;

    Vm internal immutable vm = Vm(HEVM_ADDRESS);

    AuditNFT private nft;

    Utilities internal utils;
    address payable[] internal users;

    constructor() {
        nft = new AuditNFT();
    }

    function setUp() public {
        utils = new Utilities();
        users = utils.createUsers(5);
    }

    function testFuzzTokenId(AuditLibrary.AuditSlot memory slot) public {
        uint256 id = slot.toTokenId();
        emit log_uint(id);
        AuditLibrary.AuditSlot memory parsed = AuditLibrary.parseTokenId(id);
        assertEq(slot.auditFirmId, parsed.auditFirmId);
        assertEq(slot.nonuce, parsed.nonuce);
        assertEq(slot.totalEngineeringDay, parsed.totalEngineeringDay);
        assertEq(slot.startTimestamp, parsed.startTimestamp);
        assertEq(slot.endTimestamp, parsed.endTimestamp);
    }
}
