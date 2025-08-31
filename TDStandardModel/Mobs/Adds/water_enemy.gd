extends BasicEnemy

@export var regenRatio = 0.01


func onTimerRegen():
	if health + maxHealth*regenRatio > maxHealth:
		health = maxHealth
	else:
		health += maxHealth*regenRatio
			
func death_effects():
	Global.playerScoreP += 0.5	
	#print("Blue enemy killed, adding .5 points to score")
	
	self.queue_free()
		
