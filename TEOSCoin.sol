// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/*
 * Import OpenZeppelin contracts for ERC20 token with pausable transfers,
 * ownership control, and safe minting/burning.
 */
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Pausable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title TEOSCoin
 * @dev Custom ERC20 token with mint, burn, and pause functionality.
 */
contract TEOSCoin is ERC20Pausable, Ownable {
    uint256 private constant INITIAL_SUPPLY = 1_000_000_000 * 10 ** 18;

    /**
     * @dev Constructor mints the initial supply to the specified owner.
     * @param _owner The address to receive the initial supply and own the contract.
     */
    constructor(address _owner) ERC20("TEOS", "TEOS") Ownable(_owner) {
        _mint(_owner, INITIAL_SUPPLY);
    }

    /**
     * @dev Burn tokens. Anyone can burn their own tokens.
     * @param amount Amount of tokens to burn.
     */
    function burn(uint256 amount) external whenNotPaused {
        _burn(msg.sender, amount);
    }

    /**
     * @dev Mint new tokens. Only the owner can mint tokens.
     * @param to The address that will receive the minted tokens.
     * @param amount The amount of tokens to mint.
     */

    /**
     * @dev Transfer tokens. Inherited from ERC20. 
     * Transfer will be paused if contract is paused.
     * @param to The address to which tokens are transferred.
     * @param amount The amount of tokens to transfer.
     */
    function transfer(address to, uint256 amount) public override whenNotPaused returns (bool) {
        return super.transfer(to, amount);
    }

    /**
     * @dev Approve tokens for spender. Inherited from ERC20.
     * Approve will be paused if contract is paused.
     * @param spender The address approved to spend tokens.Remix - Ethereum IDE logo


     * @param amount The amount of tokens allowed to be spent.
     */
    function approve(address spender, uint256 amount) public override whenNotPaused returns (bool) {
        return super.approve(spender, amount);
    }

    /**
     * @dev Transfer tokens from another address. Inherited from ERC20.
     * Transfer will be paused if contract is paused.
     * @param from The address from which tokens are transferred.
     * @param to The address to which tokens are transferred.
     * @param amount The amount of tokens to transfer.
     */
    function transferFrom(address from, address to, uint256 amount) public override whenNotPaused returns (bool) {
        return super.transferFrom(from, to, amount);
    }

    /**
     * @dev Pause all token transfers and mint/burn operations. Only owner can call.
     */
    function pause() external onlyOwner {
        _pause();
    }

    /**
     * @dev Unpause token transfers, minting, and burning. Only owner can call.
     */
    function unpause() external onlyOwner {
        _unpause();
    }
}