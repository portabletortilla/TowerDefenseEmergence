extends Node

var currLevel=1
var health = 20
var currency = 25
var dropRateStagnant = 0.6
var dropRate = dropRateStagnant
var presentMult = 1
var currentRound = 0
var nRounds = 5

var sellRatio = 1.0
var srDict = {1:1.0,
			  2:0.9,
			  3:0.75}
var srDegradation = {1:0,
			 		 2:0.05,
			  		 3:0.125}

var intensityDict=[[0,1,1],
				   [0,3,3,4],
				   [0,5,5,6,6]]

var playerScoreP = 0
var leftoverResMult = 1.2
var hPMult= 10

var intensityValue = 3
var totalPlayerScore = 0

#evaluation value that operates over the game, initiated at 3 for round 1
var PlayerRank = 3

var enemyStatTable={"1-1":1.0,"1-2":1.05,"1-3":1.1,
					"2-1":1.0,"2-2":1.1,"2-3":1.3,"2-4":1.55,
					"3-1":1.0,"3-2":1.2,"3-3":1.5,"3-4":2.0,"3-5":3.0,}

#base enemy stats that are iterated on during each round, initiated with this value at the start of a level
var baseEnemyTemplatesStats = [5, 1.5, 5.0, 2.00, 80]

# enemy line up [G,R,Y,B]

var waveLineUp =  [ 
				  [ [1,10], [2,5] ] ,
				  [ [1,25], [2,10], [3,2], [4,0] ],
				  [ [1,30], [2,25], [4,1] ],
				  [ [1,45], [2,45], [3,5], [4,1] ],
				  [ [1,100], [2,30], [3,20], [4,5] ]
				  ]
				
var waveLineUpAux = waveLineUp.duplicate(true)

#initiallized on scene handler
var ExpectedScorePerLevel= {}
