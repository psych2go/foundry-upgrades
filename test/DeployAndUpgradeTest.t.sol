// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Test} from "forge-std/Test.sol";
import {BoxV1} from "../src/BoxV1.sol";
import {BoxV2} from "../src/BoxV2.sol";
import {DeployBox} from "../script/DeployBox.s.sol";
import {UpgradeBox} from "../script/UpgradeBox.s.sol";

contract DeployAndUpgradeTest is Test {
    DeployBox public deployer;
    UpgradeBox public upgrader;
    address public OWNER = makeAddr("owner");

    address public proxy;

    modifier Upgrade() {
        BoxV2 boxV2 = new BoxV2();
        upgrader.upgradeBox(proxy, address(boxV2));
        _;
    }

    function setUp() public {
        deployer = new DeployBox();
        upgrader = new UpgradeBox();
        proxy = deployer.run();
    }

    ////////////////////
    // Before Upgrade //
    ////////////////////

    function testNotUpgradesVersion() public {
        assertEq(BoxV1(proxy).version(), 1);
    }

    function testNotUpgradesSetNumber() public {
        vm.expectRevert();
        BoxV2(proxy).setNumber(7);
    }

    ////////////////////
    // After Upgrade  //
    ////////////////////

    function testUpgradesVersion() public Upgrade {
        assertEq(BoxV2(proxy).version(), 2);
    }

    function testUpgradesSetNumber() public Upgrade {
        BoxV2(proxy).setNumber(7);
        assertEq(BoxV2(proxy).getNumber(), 7);
    }
}
