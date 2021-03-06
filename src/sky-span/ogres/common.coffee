###
common methods
###

if not @plans
  @plans =
    a:
      id: "protect thowers"

    b:
      id: "kill captains"

if not @currentPlan
  @currentPlan = @plans.a

if not @allEnemiesCaptainsNames
  @allEnemiesCaptainsNames = []

if not @checkPlan
  @checkPlan = ->
    for captain in @enemyCaptains
      if @allEnemiesCaptainsNames.indexOf(captain.id) == -1
        @allEnemiesCaptainsNames.push captain.id
    if @now() > 10 and @allEnemiesCaptainsNames.length >= 2
      @say "kill enemy captains!!!"
      @currentPlan = @plans.b
    return

if not @getUnits
  @getUnits = (type, isEnemy) ->
    if isEnemy
      units = @enemies
    else
      units = @friends
    units.filter( (unit) ->
      unit.type == type
    )

if not @inAttackRange
  @inAttackRange = (unit, enemies) ->
    enemies.filter( (enemy) ->
      unit.distance(enemy) <= unit.attackRange
    )


###
check battle field
###

@friends = @getFriends()
@enemies = @getEnemies()

@myThrowers      = @getUnits('thrower')
@myMunchkins     = @getUnits('munchkin')
@myShaman        = @getUnits('shaman')[0]
@myFangrider     = @getUnits('fangrider')[0]
@enemyCaptains   = @getUnits('captain', true);
@enemyArchers    = @getUnits('archer', true);
@enemySoldiers   = @getUnits('soldier', true);
@enemyCommander  = @getUnits('commander', true)[0];

###
check plan
###

@checkPlan()
