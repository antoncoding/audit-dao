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
            (uint256(slot.endTimestamp));
    }

    function parseTokenId(uint256 _tokenId)
        internal
        pure
        returns (AuditSlot memory)
    {
        uint32 auditFirmId;
        uint32 nonuce;
        uint64 totalEngineeringDay;
        uint64 startTimestamp;
        uint64 endTimestamp;
        assembly {
            auditFirmId := shr(224, _tokenId)
            nonuce := shr(192, _tokenId)
            totalEngineeringDay := shr(128, _tokenId)
            startTimestamp := shr(64, _tokenId)
            endTimestamp := _tokenId
        }
        return
            AuditSlot({
                auditFirmId: auditFirmId,
                nonuce: nonuce,
                totalEngineeringDay: totalEngineeringDay,
                startTimestamp: startTimestamp,
                endTimestamp: endTimestamp
            });
    }
}
