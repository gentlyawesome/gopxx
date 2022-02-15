// contracts/GLDToken.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "hardhat/console.sol";

contract GOPXX is ERC20, Ownable {
    mapping (address => uint256) internal _balances;
    address private _owner;

    constructor(uint256 initialSupply) ERC20("GameOnPlayersX", "GOPXX") Ownable()  {
        _mint(msg.sender, initialSupply);
    }
}

/*
interface IUniswap {
    function getAmountsIn(uint256 amountOut, address[] memory path) external view returns(uint256[] memory amounts);
}

contract GOPXX is ERC20, Ownable {
    mapping (address => uint256) internal _balances;
    address private _owner;

    IUniswap public router = IUniswap(0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D);
    address public fundReceiver; // Fund Receiver address is that address where token purchased funds will go and it will send the tokens.
    uint256 public runningPhase = 1; // This is the current running phase No. of token price.
    uint256 public lockedTimeInterval = 90*(24*60*60);

    struct PhasesStructure {
        uint256 usdPrice;
        uint256 endTimestamp;
    }

    mapping(address => uint256) public lockedTimestamp; // This is the locked timestamp (90 days after purchase). After this timestamp the tokens will unlocked.
    mapping(uint256 => PhasesStructure) public phases;  // This mapping contains phases information (Price, endingTimestamp). 

    constructor(address owner_, address _fundReceiver) ERC20("Game On Players", "GOPXX") Ownable(owner_) {
        fundReceiver = _fundReceiver;
        _mint(owner_, 10000000000*(10**18));
        phases[1] = PhasesStructure(1*(10**6), 1638234000); // Timestamp for Tuesday, November 30, 2021 1:00:00 AM.
        phases[2] = PhasesStructure(20*(10**6), 1646010000); // Timestamp for Monday, February 28, 2022 1:00:00 AM.
        phases[3] = PhasesStructure(100*(10**6), 1653958800); // Timestamp for Tuesday, May 31, 2022 1:00:00 AM.
        phases[4] = PhasesStructure(500*(10**6), 1685581200); // Timestamp for Thursday, June 1, 2023 1:00:00 AM.
        phases[5] = PhasesStructure(2500*(10**6), ~uint256(0)); // Timestamp to max. Fifth phase do not have end.
    }


    function getEthValue(uint256 _usdAmount) private view returns (uint256 amount) {
        // This function is just to calculate the current eth price as usdt it is using the uniswap router. and the pair ETH-USDT.
        address[] memory path = new address[](2);
        // This is the address of WETH.
        // ropsten: 0xc778417E063141139Fce010982780140Aa0cD5Ab
        // mainnet: 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2
        path[0] = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2; 
        // This is USDT Address. Decimals of the USDT is 6 So, we have to make assure we added 6 zeroes after the value of usdt.
        // ropsten: 0x07865c6E87B9F70255377e024ace6630C1Eaa37F
        // mainnet: 0xdAC17F958D2ee523a2206206994597C13D831ec7
        path[1] = 0xdAC17F958D2ee523a2206206994597C13D831ec7;
        return router.getAmountsIn(_usdAmount, path)[0];
    }

    // Overriding the default _transfer function to add lock functionality.
    function _transfer(address sender, address recipient, uint256 amount) internal override virtual {
        require(sender != address(0), "ERC20: transfer from the zero address");
        require(recipient != address(0), "ERC20: transfer to the zero address");
        if(address(sender) != address(fundReceiver) && address(sender) != address(owner())) {
            require(lockedTimestamp[sender] < block.timestamp, "90 Days locked duration not ended yet.");
        }

        _beforeTokenTransfer(sender, recipient, amount);

        uint256 senderBalance = _balances[sender];
        require(senderBalance >= amount, "ERC20: transfer amount exceeds balance");
        _balances[sender] = senderBalance - amount;
        _balances[recipient] += amount;

        updateRunningPhase();
        emit Transfer(sender, recipient, amount);
    }

    // This function is just to increase the count of running phase if the time of the running phase is over.
    function updateRunningPhase() private {
        if(phases[runningPhase].endTimestamp < block.timestamp) {
            runningPhase++;
        }
    }

    // This function is to check the latest update of token price respect the the running phase.
    function getTokenPrice() public view returns(uint256 amount) {
        return getEthValue(phases[runningPhase].usdPrice);
    }

    // Public function to buy tokens It need to set value more then 0 to buy tokens.
    // will send token amount and receive eth on the behalf of USDT stable coin price.
    function buyTokens() public payable {
        updateRunningPhase();
        require(msg.value > 0, "Value must be greater then 0.");
        uint256 ethPrice = getTokenPrice();
        uint256 tokenAmount = (msg.value * (10**decimals()))/ethPrice;
        require(tokenAmount > 0, "Computed Token amount must be greater then 0.");
        _transfer(fundReceiver, msg.sender, tokenAmount);
        payable(fundReceiver).transfer(msg.value);
        lockedTimestamp[msg.sender] = lockedTimeInterval + block.timestamp; 
    }

    // This is to update fund receiver address.
    function updateFundReceiver(address _newAddress) public onlyOwner {
        fundReceiver = _newAddress;
    }

    // This is to update faces.
    function updatePhases(uint256 _phaseNumber, uint256 _usdPrice, uint256 _endTimestamp) public onlyOwner {
        phases[_phaseNumber].usdPrice = _usdPrice;
        phases[_phaseNumber].endTimestamp = _endTimestamp;
    }

    function updateLockedTimeInterval(uint256 _newInterval) public onlyOwner {
        lockedTimeInterval = _newInterval;
    }
}
*/
