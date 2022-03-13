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

    Utilities internal utils;

    function setUp() public {
        utils = new Utilities();
    }

    /// @dev fuzz test that we can generate tokenId from an audit struct, and also parse the property from the id.
    function testFuzzTokenId(AuditLibrary.AuditSlot memory slot) public {
        uint256 id = slot.toTokenId();
        AuditLibrary.AuditSlot memory parsed = AuditLibrary.parseTokenId(id);
        assertEq(slot.auditFirmId, parsed.auditFirmId);
        assertEq(slot.nonuce, parsed.nonuce);
        assertEq(slot.totalEngineeringDay, parsed.totalEngineeringDay);
        assertEq(slot.startTimestamp, parsed.startTimestamp);
        assertEq(slot.endTimestamp, parsed.endTimestamp);
    }
}
