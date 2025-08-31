extends CharacterBody2D
class_name BasicEnemy

@export var healthCoef = 1.0
@export var defenseCoef = 1.0
@export var fRCoef = 1.0
@export var damageCoef = 1.0
@export var speedCoef = 1.0

@export var maxHealth = 10.0
@export var defense = 1.0
@export var fireResistance = 0.0
@export var damage = 5.0
@export var defaultFallingSpeed = 120
var speed
@onready var health = maxHealth
#values to save old stats
var maxHealthBase
var speedBase
var damageBase
#Healing per second
@export var hps = 0.0
@export var shielding = 0
@onready var debuffed = 0
var alive = true
@export var oscilationSpeed = 1
@export var initialRotation=0.0
@export var freq = 2
@export var time = 0.0
@export var amp = 2
var startingDirection = 1

var gift = preload("res://Mobs/Drops/Reward.tscn")

func _ready(): 
	get_node("HealthComponent/healthBar").setup()
	
func _process(_delta):
	get_node("HealthComponent/healthBar").global_position = self.global_position + Vector2(-25,-25)
	if health <=0 and alive:
		alive=false
		if(randf() < Global.dropRate):
			spawnGift()
		death_effects()	
			
	if(shielding>=1 and not get_node("Bubble").visible):
		get_node("Bubble").show()		

func updateShield():
	if(shielding==0):
		get_node("Bubble").hide()	
			
func setup(statMult):
	self.maxHealthBase = Global.baseEnemyTemplatesStats[0] * statMult * self.healthCoef
	 
	self.defense = Global.baseEnemyTemplatesStats[1] *  statMult * self.defenseCoef
	
	
	self.fireResistance = Global.baseEnemyTemplatesStats[2] *  statMult * self.fRCoef
	
	self.damage = Global.baseEnemyTemplatesStats[3] *  statMult * self.damageCoef
	
	self.speedBase = Global.baseEnemyTemplatesStats[4] *  statMult * self.speedCoef 
	speed = speedBase
	if randf() < 0.5:
		self.startingDirection = -1
	
	var auxTimer1 =	3.5 * (1.0 - fireResistance)
	var auxTimer2 = 1.5 *(1.0 + fireResistance)
	if auxTimer1 <=0:
		auxTimer1=1	
		
	get_node("Timers/DebuffTimer").wait_time = auxTimer1		
	get_node("Timers/ImmunityTimer").wait_time = auxTimer2
	get_node("Bubble").play()	
			
func _physics_process(_delta: float):
	if(oscilationSpeed == 0):
		fall()
	else:	
		time+= _delta
		rotation = cos(freq*time) * amp/PI + initialRotation
		#print(rotation)
		self.velocity = Vector2(0,1).rotated(rotation * startingDirection) * speed 
		move_and_slide()

func fall():
	velocity.y = speed
	move_and_slide()	

func spawnGift():
	var g = gift.instantiate()
	g.global_position = self.global_position
	get_parent().get_parent().get_node("Drops").add_child(g) 

func debuff_timer_start():
	#print("half speed")
	#print(str(get_node("Timers/DebuffTimer").wait_time))
	get_node("Timers/DebuffTimer").start()
#Enemy returns to normal speed after a period of time
func _on_debuff_timer_timeout():
	#print("normal speed again")
	speed = defaultFallingSpeed
	get_node("Timers/ImmunityTimer").start()

func _on_immunity_timer_timeout():
	#print("can be debuffed again")
	debuffed=0

func takeDamage(dmg):
	var d = dmg - self.defense
	if(d < dmg*0.1):
		d = dmg*0.1
	self.health -= d
		
func death_effects():
	Global.playerScoreP += 0.5
	get_tree().get_root().get_node("SceneHandler/Map"+str(Global.currLevel)).updateScore()
	#print("Green Enemy killed, adding .5 points to score")
	self.queue_free()	

