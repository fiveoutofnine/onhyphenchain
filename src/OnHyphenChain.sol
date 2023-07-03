// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import {ERC721} from "solmate/tokens/ERC721.sol";
import {LibString} from "solady/utils/LibString.sol";
import {Base64} from "./utils/Base64.sol";

contract OnHyphenChain is ERC721 {
    using LibString for uint256;

    /// @notice The total number of tokens.
    uint256 totalSupply;

    // -------------------------------------------------------------------------
    // Constructor + Mint
    // -------------------------------------------------------------------------

    /// @notice Deploys the contract.
    constructor() ERC721("On-Chain", "O-C") {
        unchecked {
            _mint(msg.sender, ++totalSupply);
        }
    }

    /// @notice Mints a token to the sender.
    function mint() external {
        unchecked {
            _mint(msg.sender, ++totalSupply);
        }
    }

    // -------------------------------------------------------------------------
    // ERC721Metadata
    // -------------------------------------------------------------------------

    /// @inheritdoc ERC721
    function tokenURI(
        uint256 _tokenId
    ) public view override returns (string memory) {
        require(_ownerOf[_tokenId] != address(0), "ERC721: TOKEN_UNMINTED");

        uint256 fontSize;
        if (totalSupply < 20) fontSize = 256;
        else if (totalSupply < 98) fontSize = 128;
        else if (totalSupply < 410) fontSize = 64;
        else if (totalSupply < 1658) fontSize = 32;
        else if (totalSupply < 6650) fontSize = 16;
        else if (totalSupply < 26618) fontSize = 8;
        else if (totalSupply < 106490) fontSize = 4;
        else if (totalSupply < 425978) fontSize = 2;
        else if (totalSupply < 1703930) fontSize = 1;

        return
            string.concat(
                "data:application/json;base64,",
                Base64.encode(
                    abi.encodePacked(
                        '{"name":"',
                        "On-Chain #",
                        _tokenId.toString(),
                        '",',
                        '"image":"data:image/svg+xml;base64,',
                        Base64.encode(
                            abi.encodePacked(
                                '<svg width="1024" height="1024" viewBox="0 0 1024 1024" fill="none" xmlns="http://www.w3.org/2000/svg"><style>@font-face{font-family:A;src:url(data:font/woff2;utf-8;base64,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)}</style><path fill="#57bef5" d="M0 0h1024v1024H0z"/><foreignObject x="0" y="0" width="1024" height="1024"><p xmlns="http://www.w3.org/1999/xhtml" style="overflow-wrap:break-word;font-size:',
                                fontSize.toString(),
                                'px;color:#000;font-family:A;line-height:1">on',
                                LibString.repeat("-", totalSupply),
                                "chain</p></foreignObject></svg>"
                            )
                        ),
                        '"}'
                    )
                )
            );
    }
}
