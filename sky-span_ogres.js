var throwers  = [],
    munchkins = [],
    hero;

this.getFriendsByType = function (type) {
    return this.getFriends().filter(function (friend) {
        return friend.type === type;
    });
};

throwers  = this.getFriendsByType('thrower');
munchkins = this.getFriendsByType('munchkin');
hero      = this.getFriendsByType('shaman')[0];

// This is your commander's code. Decide which unit to build each frame.
// Destroy the enemy base within 90 seconds!
// Check out the Guide at the top for more info.
/////// 1. Choose your hero. /////////////////////////////////////////
// Heroes cost 100 gold. You start with 100 and earn 10 per second.

//hero = 'ironjaw';   // A leaping juggernaut hero, type 'brawler'.
//hero = 'yugargen';  // A devious spellcaster hero, type 'shaman'.
//hero = 'dreek';     // A deadly spear hero, type 'fangrider'.

/////// 2. Choose which unit to build each turn. /////////////////////
// Munchkins are weak melee units who cost 11 gold.
// Throwers are fragile, deadly ranged units who cost 25 gold.
// Units you build will go into the this.built array.

this.getBuildType = function () {
    if (munchkins.length < 4)
        return 'munchkin';
    if (!hero)
        return 'yugargen';
    return 'thrower';
};

this.buildByType = function (type) {
    if (this.buildables[type].goldCost <= this.gold) {
        this.build(type);
        return true;
    }
};

this.buildByType(this.getBuildType());

/////// 3. Command minions to implement your tactics. ////////////////
// Minions obey 'move' and 'attack' commands.
// Click on a minion to see its API.

this.munchkinAttack = function (munchkin) {
    var nearestEnemy;
    nearestEnemy = munchkin.getNearestEnemy();
    if (munchkin.distance(nearestEnemy) <= munchkin.attackRange) {
        this.command( munchkin, 'attack', nearestEnemy );
        return true;
    }
    return false;
};

this.munchkinStandby = function (munchkin) {
    if (throwers.length === 0)
        return true;
    return false;
};

this.munchkinPush = function (munchkin) {
    var distance = 6;
    var nearestThrower;

    nearestThrower = munchkin.getNearest(throwers);
    if (nearestThrower && munchkin.pos.x >= nearestThrower.pos.x - distance) {
        this.command(munchkin, 'move', {
            x: munchkin.pos.x - distance,
            y: munchkin.pos.y
        });
        return true;
    }
    return false;
};

this.commandMunchkin = function (munchkin) {
    if (this.munchkinAttack(munchkin))
        return;
    if (this.munchkinStandby(munchkin))
        return;
    if (this.munchkinPush(munchkin))
        return;
    return false;
};

this.commandThrower = function (thrower) {
    var nearestThrower, nearestEnemy, inRange;
    nearestEnemy = thrower.getNearestEnemy();
    inRange = thrower.distance(nearestEnemy) <= thrower.attackRange;
    if (inRange) {
        this.command(thrower, 'attack', nearestEnemy);
        return;
    }
    this.command(thrower, 'move', {
        x: thrower.pos.x - 1,
        y: thrower.pos.y
    });
};

for (var i = 0; i < munchkins.length; i++) {
    this.commandMunchkin(munchkins[i]);
}

for (i = 0; i < throwers.length; i++) {
    this.commandThrower(throwers[i]);
}
