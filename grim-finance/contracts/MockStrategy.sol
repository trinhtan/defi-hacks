// SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;

import "./dependencies/SafeERC20.sol";

contract MockStrategy {
    using SafeERC20 for IERC20;

    address public want;
    address public vault;
    address public strategist;

    constructor(
        address _want,
        address _vault,
        address _strategist
    ) public {
        want = _want;
        vault = _vault;
        strategist = _strategist;
    }

    function balanceOfPool() public view returns (uint256) {
        return IERC20(want).balanceOf(address(this));
    }

    function deposit() public {
        require(msg.sender == vault || msg.sender == strategist, "!authorized");
    }

    function withdraw(uint256 _amount) external {
        require(msg.sender == vault, "!vault");
        IERC20(want).safeTransfer(vault, _amount);
    }

    function setVault(address _vault) external {
        vault = _vault;
    }
}
