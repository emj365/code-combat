# Shamans are spellcasters with a weak magic attack
# and four spells: 'shrink', 'grow', 'raise-dead', and 'poison-cloud'.
# 'shrink': target has 2/3 health, 1.5x speed for 5s.
# 'grow': target has triple health, 0.6x speed for 5s.
# 'raise-dead': raises two random corpses for 5s.
# 'poison-cloud': once per match, 5 poison DPS for 10s in a 15m radius.

# Chill if all enemies are dead.
@say '¯\\_(ツ)_/¯ 哈哈哈' if not @enemyCommander

# Which one do you do at any given time? Only the last called action happens.

# if not @followTheThrower
#   @followTheThrower = ->
#     dis = @distance(@myMunchkins[0])
#     keepDis = @options.shamanDistance
#     fixDis = keepDis / 2
#     if dis > keepDis + fixDis or dis < keepDis - fixDis
#       @move
#         x: @myMunchkins[0].pos
#         y: 25

if not @hitLastInRangeArcher
  @hitLastInRangeArcher = ->
    inRangeArchers = @inAttackRange(this, @enemyArchers)
    if inRangeArchers.length == 0
      return false
    [first, ..., last] = inRangeArchers
    @attack last
    true

if not @growMunchkin
  @growMunchkin = ->
    if @myMunchkins.length == 0
      return false
    munchkin = @myMunchkins[Math.floor(@myMunchkins.length / 2)]
    if @canCast("grow", munchkin)
      @castGrow munchkin
      true

if not @hitNearestSoldier
  @hitNearestSoldier = ->
    if @enemySoldiers.length == 0
      return false
    soldier = @getNearest(@enemySoldiers)
    @attack soldier
    true

if not @shrinkNearestSoldier
  @shrinkNearestSoldier = ->
    if @enemySoldiers.length == 0
      return false
    soldier = @getNearest(@enemySoldiers)
    if @canCast("shrink", soldier)
      @castShrink soldier
      return true
    false

###
# execute
###

# follow thrower to push forward
# return  if @followTheThrower()

# hit far archer first
return  if @hitLastInRangeArcher()

# grow munchkin that in middle
return  if @growMunchkin()

# if @canCast('raise-dead')
#   @castRaiseDead();

# shrink nearest soldier
return  if @shrinkNearestSoldier()

# try kill nearest soldier
return  if @hitNearestSoldier()

@move
  x: this.pos.x
  y: 25

# You can store state on this across frames:
# this.lastHealth = this.health;
