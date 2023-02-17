pragma solidity 0.8.10;

import "forge-std/Test.sol";

error Unauthorized();

contract OwnerUpOnly {
    address public immutable owner;
    uint256 public count;

    constructor() {
        owner = msg.sender;
    }
    
    function increment() external {
        if (msg.sender != owner) {
            revert Unauthorized();
        }
        count++;
    }
}

pragma solidity 0.8.10;
contract OwnerUpOnlyTest is Test {
    OwnerUpOnly public upOnly;

    function setUp() public {
        upOnly = new OwnerUpOnly();
    }

    function testIncrementAsOwner() public {
        assertEq(upOnly.count(), 0);
        upOnly.increment();
        assertEq(upOnly.count(), 1);
    }
    //The test case passed since we used the testFail prefix, however,
    //using testFail is considered an anti-pattern since it does not tell us anything about why upOnly.increment() reverted.
    function testFailIncrementAsNotOwner() public {
        vm.prank(address(0));
        upOnly.increment();
    }

    
    function testIncrementAsNotOwner() public {
        vm.expectRevert(Unauthorized.selector);
        vm.prank(address(0));
        upOnly.increment();
    }
}