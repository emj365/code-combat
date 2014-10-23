###
define methods for commander
###

if not @getBuildType
  @getBuildType = ->
    # return "dreek"  if @enemyCaptains.length >= 2 and not @myFangrider
    return "munchkin"  if @myMunchkins.length < @options.munchkinsNeed
    return "yugargen"  unless @myShaman
    "thrower"

if not @buildByType
  @buildByType = (type) ->
    if @buildables[type].goldCost <= @gold
      @build type
      true

if not @munchkinAttack
  @munchkinAttack = (munchkin) ->
    nearestEnemy = munchkin.getNearestEnemy()
    if munchkin.distance(nearestEnemy) <= munchkin.attackRange * 2.5
      @command munchkin, "attack", nearestEnemy
      return true
    false

if not @munchkinStandby
  @munchkinStandby = (munchkin) ->
    return true  if @myThrowers.length is 0
    false

if not @munchkinPush
  @munchkinPush = (munchkin) ->
    nearestThrower = munchkin.getNearest(@myThrowers)
    if nearestThrower and munchkin.pos.x + @options.keepDistance >= nearestThrower.pos.x
      @command munchkin, "move",
        x: munchkin.pos.x - @options.keepDistance
        y: munchkin.pos.y
      return true
    false

if not @commandMunchkin
  @commandMunchkin = (munchkin) ->
    return  if @munchkinAttack(munchkin)
    return  if @munchkinStandby(munchkin)
    return  if @munchkinPush(munchkin)
    false

if not @commandThrower
  @commandThrower = (thrower) ->
    nearestThrower = undefined
    nearestEnemy = undefined
    inRange = undefined
    nearestEnemy = thrower.getNearestEnemy()
    inRange = thrower.distance(nearestEnemy) <= thrower.attackRange
    if inRange
      @command thrower, "attack", nearestEnemy
      return
    @command thrower, "move",
      x: thrower.pos.x - @options.pushSpeed
      y: thrower.pos.y
    return

###
Run
###

for myThrower in @myThrowers
  @commandThrower(myThrower)

for myMunchkin in @myMunchkins
  @commandMunchkin(myMunchkin)

this.buildByType(this.getBuildType());
