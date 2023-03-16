pragma solidity ^0.8.4;

import "../lib/forge-std/src/Script.sol";
import "../src/Spacebear.sol";

contract DeployScript is Script {
    function setUp() public {}

    function run() public {
        string memory seedPhrase = vm.readFile(".secret");
        uint privateKey = vm.deriveKey(seedPhrase, 0);
        vm.startBroadcast(privateKey);
        Spacebear bear = new Spacebear();

        vm.stopBroadcast();
    }
}