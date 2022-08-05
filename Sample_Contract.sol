/**
 *   ########################################################################
 *   ##################   Structure of a Contract ###########################
 *   ########################################################################
 */

/**
 *    ------------------------------------------------------------------------
 *   |                         State Variables                                |
 *    ------------------------------------------------------------------------
 */

pragma solidity >=0.4.0 <0.7.0;

contract SimpleStorage {
    uint256 storedData; // State variable
    string Name;
    address PublicAddress;
    bool claimed;
    // ...
}
/**  State Variable Visibility : Public, Private, Internal */

/** **************************************************************************************************** */

/**
 *    ------------------------------------------------------------------------
 *   |                              Functions                                |
 *    ------------------------------------------------------------------------
 */

pragma solidity >=0.7.1 <0.9.0;

contract SimpleAuction {
    function bid() public payable returns (bool) {
        // Function
        // ...
    }
}

// Helper function defined outside of a contract
function helper(uint256 x) pure returns (uint256) {
    return x * 2;
}

/**  Function Visibility : external, public, internal, private */
/**  State Mutability : view, pure  */

/** **************************************************************************************************** */

/**
 *    ------------------------------------------------------------------------
 *   |                       Functions Modifiers                              |
 *    ------------------------------------------------------------------------
 */

pragma solidity >=0.4.22 <0.9.0;

contract Purchase {
    address public seller;

    modifier onlySeller() {
        // Modifier
        require(msg.sender == seller, "Only seller can call this.");
        _;
    }

    function abort() public view onlySeller {
        // Modifier usage
        // ...
    }
}

/** **************************************************************************************************** */

/**
 *    ------------------------------------------------------------------------
 *   |                             Events                                     |
 *    ------------------------------------------------------------------------
 */

pragma solidity >=0.4.21 <0.9.0;

contract SimpleAuction {
    event HighestBidIncreased(address bidder, uint256 amount); // Event

    function bid() public payable {
        // ...
        emit HighestBidIncreased(msg.sender, msg.value); // Triggering event
    }
}

/** **************************************************************************************************** */

/**
 *    ------------------------------------------------------------------------
 *   |                       Struct Types                                     |
 *    ------------------------------------------------------------------------
 */

pragma solidity >=0.4.0 <0.9.0;

contract Ballot {
    struct Voter {
        uint256 weight;
        bool voted;
        address delegate;
        uint256 vote;
    }
}

/** **************************************************************************************************** */

/**
 *    ------------------------------------------------------------------------
 *   |                        Enum Types                                     |
 *    ------------------------------------------------------------------------
 */

pragma solidity >=0.4.0 <0.9.0;

contract Purchase {
    enum State {
        Created,
        Locked,
        Inactive
    } // Enum
}

/** **************************************************************************************************** */

/**
 *    ------------------------------------------------------------------------
 *   |                            Errors                                     |
 *    ------------------------------------------------------------------------
 */

pragma solidity ^0.8.4;

/// Not enough funds for transfer. Requested `requested`,
/// but only `available` available.
error NotEnoughFunds(uint256 requested, uint256 available);

contract Token {
    mapping(address => uint256) balances;

    function transfer(address to, uint256 amount) public {
        uint256 balance = balances[msg.sender];
        if (balance < amount) revert NotEnoughFunds(amount, balance);
        balances[msg.sender] -= amount;
        balances[to] += amount;
        // ...
    }
}

/** Error handling: Assert, Require, Revert and Exceptions */
/** **************************************************************************************************** */
