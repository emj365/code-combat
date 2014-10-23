# Shamans are spellcasters with a weak magic attack
# and four spells: 'shrink', 'grow', 'raise-dead', and 'poison-cloud'.
# 'shrink': target has 2/3 health, 1.5x speed for 5s.
# 'grow': target has triple health, 0.6x speed for 5s.
# 'raise-dead': raises two random corpses for 5s.
# 'poison-cloud': once per match, 5 poison DPS for 10s in a 15m radius.

# Chill if all enemies are dead.
@say '¯\\_(ツ)_/¯ 哈哈哈' if not @enemyCommander

# Which one do you do at any given time? Only the last called action happens.
enemy = @getNearest(@enemies)
friend = @getNearest(@friends)
enemyInMiddle = @enemies[Math.round( @enemies.length / 2 )]

if @enemies.length > 5 and enemyInMiddle.pos.x < 35 and @canCast("poison-cloud", enemyInMiddle)
  @castPoisonCloud enemyInMiddle
  return
if @canCast("shrink", enemyInMiddle)
  @castShrink enemyInMiddle
  return
if @canCast("grow", friend)
  @castGrow friend
  return
@attack enemyInMiddle

# if(this.canCast('raise-dead')) this.castRaiseDead();

# You can store state on this across frames:
#this.lastHealth = this.health;
