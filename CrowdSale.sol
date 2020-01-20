pragma solidity ^0.5.0;

import "./PupperCoin.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/crowdsale/Crowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/crowdsale/emission/MintedCrowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/crowdsale/validation/CappedCrowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/crowdsale/validation/TimedCrowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/crowdsale/distribution/RefundablePostDeliveryCrowdsale.sol";


contract PupperCoinSale is Crowdsale, MintedCrowdsale {

    constructor(
        uint rate,
        address payable wallet,
        PupperCoin token
    )
        Crowdsale(rate, wallet, token) public {


    }
}

contract PupperCoinSaleDeployer {

    address public PupperSaleAddress;
    address public tokenAddress;

    constructor(
        string memory name,
        string memory symbol,
        address payable wallet
    )
        public
    {
        
        PupperCoin token = new PupperCoin(name, symbol, 0);
        tokenAddress = address(token);

        
        PupperCoinSale PupperSale = new PupperCoinSale(1, wallet, token);
        PupperSaleAddress = address(PupperSale);

        
        token.addMinter(PupperSaleAddress);
        token.renounceMinter();
    }
}
