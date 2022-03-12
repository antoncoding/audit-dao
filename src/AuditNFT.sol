// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

import {ERC1155} from "solmate/tokens/ERC1155.sol";
import {Strings} from "openzeppelin/utils/Strings.sol";
import {Ownable} from "openzeppelin/access/Ownable.sol";

contract AuditNFT is ERC1155, Ownable {
    string public host;

    using Strings for uint256;

    /// @return uri for given tokenId
    function uri(uint256 _id) public view override returns (string memory) {
        return string(abi.encodePacked(host, _id.toString()));
    }

    /// @dev set the host of uri.
    function setHost(string memory _host) external onlyOwner {
        host = _host;
    }
}
