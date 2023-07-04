// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DegenToken is ERC20, Ownable {

    event Redeemed(address indexed account, uint256 indexed tokenId);

    constructor() ERC20("Degen", "DGN") {}

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    function redeem(uint256 tokenId) external {
        uint256 requiredTokens;

      
        if (tokenId == 1) {
            requiredTokens = 1000;
        } else if (tokenId == 2) {
            requiredTokens = 200;
        } else if (tokenId == 3) {
            requiredTokens = 3000;
        } else {
            revert("Invalid tokenId");
        }

        require(balanceOf(msg.sender) >= requiredTokens, "Insufficient tokens");

        _burn(msg.sender, requiredTokens);

        emit Redeemed(msg.sender, tokenId);
    }

    function burn(uint256 amount) external {
        _burn(msg.sender, amount);
    }
}
