//SPDX-License-Identifier: MIT

pragma solidity 0.8.16;


contract Consumer {
    function getBalance() public view returns (uint) {
        return address(this).balance;
    }

    function deposit() public payable {}
}
contract SmartContractWallet {
    address payable owner;
    address payable newOwner;
    mapping(address => uint) public allowance;
    mapping(address => bool) public isAllowedToSend;
    mapping(address => bool) public guardians;
    mapping(address => mapping (address => bool)) public nextOwnerGuardianVotedBool;

    uint guardianResetCount;
    uint public constant confirmationsFromGuardianForReset = 3;
    




    constructor() {
        owner = payable(msg.sender);

    }


    function setGuardian(address _guardian, bool _isGuardian) public {
        require(msg.sender == owner, "You are not the owner");
        guardians[_guardian] = _isGuardian;


    }


    function proposedOwner(address payable _newOwner) public {
        require(guardians[msg.sender], "you are not the guardian, aborting");
        require(nextOwnerGuardianVotedBool[_newOwner][msg.sender], "You have already voted for this newUser, Aborting");

        if (_newOwner != newOwner) {
            newOwner = _newOwner;
            guardianResetCount = 0;
        }

        guardianResetCount++;
        if (guardianResetCount >= confirmationsFromGuardianForReset) {
            owner = newOwner;
            newOwner = payable(address(0)); //  Reset to default
        }
        

    }

    function setAllowance(address _for, uint _amountAllowedToSend) public {
        require(msg.sender == owner, "You are not the owner");
        allowance[_for] = _amountAllowedToSend;
        if (_amountAllowedToSend > 0) {
            isAllowedToSend[_for] = true;

        } else {
            isAllowedToSend[_for] = false;
        }


    }


    function transfer(address payable _to, uint _amount, bytes memory payload) public returns(bytes memory){
        if (msg.sender != owner) {
            require(isAllowedToSend[_to], "You are not allowed to send");
            require(allowance[_to] >= _amount, "Not enough funds");
            allowance[msg.sender] -= _amount;
        }
        
        
        
        //require(msg.sender == owner, "You are not the owner");
        (bool success, bytes memory returnData) = _to.call{value: _amount}(payload);
        require(success, "Aborting, call was not successfull");

        return returnData;
    }



    receive() external payable { }
}