pragma solidity 0.8.10;

import "forge-std/Test.sol";

contract ContractBTest is Test {
    uint256 testNumber;

    //An optional function invoked before each test case is run
    function setUp() public {
        testNumber = 42;
    }
    //Functions prefixed with test are run as a test case
    function testNumberIs42() public {
        assertEq(testNumber, 42);
    }
    //The inverse of the test prefix - if the function does not revert, the test fails
    function testFailSubstract43() public {
        testNumber -= 43;
    }
    //A good practice is to use something like testCannot in combination with the expectRevert cheatcode
    //Now, instead of using testFail, you know exactly what reverted:
    function testCannotSubstract() public {
        vm.expectRevert(stdError.arithmeticError);
        testNumber -= 43;
    }
}