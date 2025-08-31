extends BasicEnemy


#percentage of resources stolen
@export var pRS = 0.05
#Resources accomulated
@onready var eA = 0

func onTimerStealRes():
	var aux = ceil(Global.currency*pRS)
	Global.currency -= aux
	eA += aux
func death_effects():
	Global.currency += eA
	Global.playerScoreP += 0.5	
	#print("Yellow enemy killed, adding .5 points to score")
	self.queue_free()	
