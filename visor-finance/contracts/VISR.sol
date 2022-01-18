// SPDX-License-Identifier: Unlicense

pragma solidity 0.7.6;

import "./ERC20.sol";
import "./Ownable.sol";

contract VISR is ERC20, Ownable {
    constructor(string memory name, string memory symbol) public ERC20(name, symbol) {}

    function mint(address account, uint256 amount) external onlyOwner {
        _mint(account, amount);
    }

    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 amount
    ) internal override(ERC20) {
        super._beforeTokenTransfer(from, to, amount);
    }
}
