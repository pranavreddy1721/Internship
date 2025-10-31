// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract GasDemo {
    uint256 public counter = 0;

    // Simple function: consumes small amount of gas
    function increment() public {
        counter += 1;
    }

    // Heavy computation: consumes more gas depending on loop count
    function heavyComputation(uint256 _loops) public {
        for (uint256 i = 0; i < _loops; i++) {
            counter += i;
        }
    }

    // Function that intentionally uses limited gas
    function callWithLimitedGas() public {
        (bool success, ) = address(this).call{gas: 10000}(
            abi.encodeWithSignature("heavyComputation(uint256)", 1000)
        );
        require(success, "Failed due to out of gas!");
    }

    // Receive Ether
    receive() external payable {}

    // Fallback to handle unknown calls or low gas
    fallback() external payable {}
}
