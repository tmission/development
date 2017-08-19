pragma solidity ^0.4.8;

contract token {function transfer(address receiver, uint amount){ }}

contract Crowdsale {
    mapping(address => uint256) public balanceOf;

    uint public amountRaised; uint public tokensCounter; uint public price; uint tokensForSending;

    token public tokenReward = token(/**/);
    address public beneficiary = /**/;
    uint public fundingGoal = 125000 ether;
    uint public tokensForSale = 270000000;
    bool public crowdsaleClosed = true;
    uint public unsoldTokensUnlock = now + 20 minutes;

    event FundTransfer(address backer, uint amount, bool isContribution);




    function discount() returns (uint) {
        if (amountRaised > 70000 ether) {
            return 0.000000067 ether;
        } else if (amountRaised > 30000 ether) {
            return 0.000000050 ether;
        } else if (amountRaised > 10000 ether) {
            return 0.000000040 ether;
        }
        return 0.000000033 ether;
    }

    function allTimeDiscount(uint msg_value) returns (uint) {
        if (msg_value >= 300000 ether) {
            return 80;
        } else if (msg_value >= 100000 ether) {
            return 85;
        }
        return 100;
    }

    function () payable {
        if (crowdsaleClosed) throw;
        price = discount();
        uint amount = msg.value;
        balanceOf[msg.sender] += amount;
        amountRaised += amount;
        tokensForSending = amount / ((price * allTimeDiscount(amount)) / 100);
        tokenReward.transfer(msg.sender, tokensForSending);
        tokensCounter += tokensForSending;
        FundTransfer(msg.sender, amount, true);
        if (beneficiary.send(amount)) {
            FundTransfer(beneficiary, amount, false);
        }
    }

    function closeCrowdsale(bool closeType){
        if (beneficiary == msg.sender) {
            crowdsaleClosed = closeType;
        }
        else {
            throw;
        }
    }

    function getUnsoldTokens() {
        if (beneficiary == msg.sender && (now >= unsoldTokensUnlock || amountRaised >= fundingGoal)) {
            tokenReward.transfer(beneficiary, tokensForSale * 10000 - tokensCounter);
            tokensForSale = 0;
        }
        else {
            throw;
        }
    }
}





































