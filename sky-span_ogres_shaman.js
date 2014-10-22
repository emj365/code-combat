// Shamans are spellcasters with a weak magic attack
// and four spells: 'shrink', 'grow', 'raise-dead', and 'poison-cloud'.
// 'shrink': target has 2/3 health, 1.5x speed for 5s.
// 'grow': target has triple health, 0.6x speed for 5s.
// 'raise-dead': raises two random corpses for 5s.
// 'poison-cloud': once per match, 5 poison DPS for 10s in a 15m radius.

var friends = this.getFriends();
var enemies = this.getEnemies();

if (enemies.length === 0)
    return;

// Chill if all enemies are dead.
var enemy = this.getNearest(enemies);
var friend = this.getNearest(friends);

// Which one do you do at any given time? Only the last called action happens.

// if(this.canCast('poison-cloud', enemy)) {
//     this.castPoisonCloud(enemy);
//     return;
// }

if (this.canCast('shrink', enemy)) {
    this.castShrink(enemy);
    return;
}
if (this.canCast('grow', friend)) {
    this.castGrow(friend);
    return;
}
this.attack(enemy);

// if(this.canCast('raise-dead')) this.castRaiseDead();

// You can store state on this across frames:
//this.lastHealth = this.health;
