// SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;

import "./dependencies/ERC20.sol";

contract MockPair is ERC20 {
    constructor() public ERC20("MockPair", "MockPair") {}

    function mint(address _account, uint256 _amount) public {
        _mint(_account, _amount);
    }
}
