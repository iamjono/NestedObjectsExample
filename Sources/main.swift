import SQLiteStORM


SQLiteConnector.db = "./gamescores"

// setup games
let gameSetup = Game()
try? gameSetup.setup()

// setup scores
let scoreSetup = Score()
try? scoreSetup.setup()

// comment out after first run
gameSetup.name = "Hello World"
do {
	gameSetup.id = try gameSetup.save() as? Int ?? 0
} catch {
	print("gameSetup error: \(error)")
}

var scoreSetup1 = Score()
scoreSetup1.game = gameSetup.id
scoreSetup1.user = "Joe"
scoreSetup1.score = 100
do {
	try scoreSetup1.save()
} catch {
	print("scoreSetup1 error: \(error)")
}
var scoreSetup2 = Score()
scoreSetup2.game = gameSetup.id
scoreSetup2.user = "Jane"
scoreSetup2.score = 102
do {
	try scoreSetup2.save()
} catch {
	print("scoreSetup2 error: \(error)")
}
var scoreSetup3 = Score()
scoreSetup3.game = gameSetup.id
scoreSetup3.user = "Andrea"
scoreSetup3.score = 101
do {
	try scoreSetup3.save()
} catch {
	print("scoreSetup3 error: \(error)")
}
// end populate


let gameTest = Game()
do {
	try gameTest.get(gameSetup.id)
} catch {
	print("gameTest.get error: \(error)")
}
print("Game ID: \(gameTest.id)")
print("Game Name: \(gameTest.name)")
gameTest._scores.forEach{
	score in
	print("Score: \(score.user), \(score.score)")
}
