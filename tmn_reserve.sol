pragma solidity ^0.4.8;

contract token {function transfer(address receiver, uint amount){ }}

contract Reserve {
    token public tokenReward = token(0x47d2564774d5a0091e18fd9e8fd713ca3c1751d4);
    address public beneficiary = 0x12364ee9b083E8126F7C50B3C3B008aec900bf51;
    uint public teamTokensUnlock = now + 180 days;
    bool public test = false;

    event FundTransfer(address backer, uint amount, bool isContribution);


    function getTeamTokens(uint tokensVal) returns (uint) {
        if (beneficiary == msg.sender && now >= teamTokensUnlock) {
            tokenReward.transfer(beneficiary, tokensVal);
            return tokensVal;
        }
        else {
            throw;
        }
    }
    
    function tst() {
        if (beneficiary != msg.sender) throw;
        test = true;
    }

}