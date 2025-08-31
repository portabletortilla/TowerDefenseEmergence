extends StaticBody2D

@export var value = 2

func _on_mouse_entered():
	Global.currency += value * Global.presentMult
	get_tree().get_root().get_node("SceneHandler/Map"+str(Global.currLevel)).updateScore()
	self.queue_free()



func _on_mouse_shape_entered(shape_idx):
	Global.currency += value * Global.presentMult
	get_tree().get_root().get_node("SceneHandler/Map"+str(Global.currLevel)).updateScore()
	self.queue_free()
