// SPDX-License-Identifier: MIT
pragma solidity 0.6.12;

contract Bank {
    address public manager;
    enum Action {
        Deposit,
        Withdrawal
    }

    struct Transactions {
        Action action;
        uint256 time;
        uint256 amount;
    }

    struct User {
        string name;
        uint256 age;
        uint256 currentBalance;
        uint256 totalTransactions;
        mapping(uint256 => Transactions) transactions;
    }

    mapping(address => User) private users;

    modifier onlyManager() {
        require(msg.sender == manager, "Only manager can register the User");
        _;
    }

    constructor() public {
        manager = msg.sender;
    }

    function registration(
        address _address,
        string memory _name,
        uint256 _age
    ) external onlyManager returns (bool) {
        User storage user = users[_address];
        user.name = _name;
        user.age = _age;
        return true;
    }

    function updateUserDetails(
        address _address,
        string memory _name,
        uint256 _age
    ) external onlyManager returns (bool) {
        User storage user = users[_address];
        user.name = _name;
        user.age = _age;
        return true;
    }

    function deposit() external payable returns (bool) {
        require(msg.value != 0, "_amount should not be zero");
        User storage user = users[msg.sender];
        user.currentBalance = user.currentBalance + msg.value;
        user.transactions[user.totalTransactions].action = Action.Deposit;
        user.transactions[user.totalTransactions].time = block.timestamp;
        user.transactions[user.totalTransactions].amount = msg.value;
        user.totalTransactions += 1;
        return true;
    }

    function withdrawal(uint256 _amount) external payable returns (bool) {
        User storage user = users[msg.sender];

        require(_amount <= user.currentBalance, "Insufficient balance");

        user.currentBalance = user.currentBalance - _amount;
        user.transactions[user.totalTransactions].action = Action.Withdrawal;
        user.transactions[user.totalTransactions].time = block.timestamp;
        user.transactions[user.totalTransactions].amount = _amount;
        user.totalTransactions += 1;

        address payable participant = msg.sender;
        (participant).transfer(_amount);
    }

    function getUserDetails(address _user)
        public
        view
        returns (
            string memory,
            uint256,
            uint256,
            uint256
        )
    {
        User memory user = users[_user];

        return (
            user.name,
            user.age,
            user.currentBalance,
            user.totalTransactions
        );
    }

    function getTransactionDetails(address _user, uint256 _txId)
        public
        view
        returns (
            Action,
            uint256,
            uint256
        )
    {
        User storage user = users[_user];

        return (
            user.transactions[_txId].action,
            user.transactions[_txId].time,
            user.transactions[_txId].amount
        );
    }
}
