// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

library AuditLibrary {
    struct AuditSlot {
        uint32 auditFirmId;
        uint32 nonuce;
        uint64 totalEngineeringDay;
        uint64 startTimestamp;
        uint64 endTimestamp;
    }

    function toTokenId(AuditSlot memory slot)
        internal
        pure
        returns (uint256 id)
    {
        id =
            (uint256(slot.auditFirmId) << 224) +
            (uint256(slot.nonuce) << 192) +
            (uint256(slot.totalEngineeringDay) << 128) +
            (uint256(slot.startTimestamp) << 64) +
            (uint256(slot.endTimestamp) << 64);
    }

    // function parseTokenId(uint256) internal returns (AuditSlot memory slot) {
    // assembly {

    // }
    // }
}
