// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

import {ERC1155} from "solmate/tokens/ERC1155.sol";
import {Strings} from "openzeppelin/utils/Strings.sol";
import {Ownable} from "openzeppelin/access/Ownable.sol";
import {AuditLibrary} from "./libraries/AuditLibrary.sol";

error TokenAlreadyExist();

contract AuditNFT is ERC1155, Ownable {
    using Strings for uint256;
    using AuditLibrary for AuditLibrary.AuditSlot;

    string public host;

    mapping(uint256 => bool) internal tokenExists;

    /// @return uri for given tokenId
    function uri(uint256 _id) public view override returns (string memory) {
        return string(abi.encodePacked(host, _id.toString()));
    }

    /// @dev set the host of uri. This is only used to by the uri function
    function setHost(string memory _host) external onlyOwner {
        host = _host;
    }

    /// @dev only owners can mint new "slot" token.
    function mintAuditToken(
        AuditLibrary.AuditSlot calldata _slot,
        bytes calldata _data
    ) external onlyOwner {
        uint256 id = _slot.toTokenId();
        if (tokenExists[id]) revert TokenAlreadyExist();
        tokenExists[id] = true;
        _mint(msg.sender, id, _slot.totalEngineeringDay, _data);
    }
}
