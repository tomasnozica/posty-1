"
Please comment me using the following template inspired by Class Responsibility Collaborator (CRC) design:
""Testing box behavior""
For the Class part:  State a one line summary. For example, ""I represent a paragraph of text"".

For the Responsibility part: Three sentences about my main responsibilities - what I do, what I know.

For the Collaborators Part: State my main collaborators and one line about how I interact with them. 

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.


    Implementation Points
"
Class {
	#name : #BoxTest,
	#superclass : #TestCase,
	#instVars : [
		'jack',
		'ben',
		'players',
		'atomicBomb',
		'moonWalk',
		'speedUp',
		'timeMachine',
		'wormHole',
		'diceOne',
		'empty',
		'deckOfCards',
		'theBlanckCard',
		'theNoEffectCards'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
BoxTest >> assertPosition: aPosition andLap: aLap of: aPlayer in: theGame [ 
	self assert: (theGame positionOf: aPlayer) equals: aPosition.
	self assert: (theGame lapOf: aPlayer) equals: aLap
]

{ #category : #running }
BoxTest >> setUp [
	super setUp.
	diceOne := SameFaceDice withFaces: 6.
	jack := Player called: 'Jack'.
	ben := Player called: 'Ben'.
	players := OrderedCollection with: jack with: ben.
	timeMachine := TimeMachineEffect new.
	theBlanckCard := CardWithNoEffect new.
	theNoEffectCards := OrderedCollection
		fromDraft: theBlanckCard
		andSize: nil.
	deckOfCards := DeckOfCards withEffects: theNoEffectCards
]

{ #category : #tests }
BoxTest >> testAtomicBomb [
	| board game |
	board := AtomicBombBoard ofSize: 5.
	board addAtomicBomb .
	game := Game withBoard: (board build) withLaps: 1 withPlayers: players with: deckOfCards.
	self assertPosition: 0 andLap: 0 of: jack in: game.
	diceOne nextRollNumber: 2.
	game newTurnWithDice: diceOne .
	self assertPosition: 0 andLap: 0 of: jack in: game.
	




]

{ #category : #tests }
BoxTest >> testMoonWalk [
	| moonwalkAndEmpty twoPlayerGame aBoard |
	moonwalkAndEmpty := OrderedCollection
		with: empty
		with: empty
		with: empty
		with: moonWalk
		with: empty.
	aBoard := Board fromDraft: moonwalkAndEmpty andSize: nil.
	twoPlayerGame := Game
		withBoard: aBoard
		withLaps: 1
		withPlayers: players
		with: deckOfCards.
	diceOne nextRollNumber: 2.
	twoPlayerGame newTurnWithDice: diceOne.
	self
		assertPosition: 2
		andLap: 0
		of: jack
		in: twoPlayerGame.
	self
		assertPosition: 0
		andLap: 0
		of: ben
		in: twoPlayerGame.
	diceOne nextRollNumber: 4.
	twoPlayerGame newTurnWithDice: diceOne.
	self
		assertPosition: 1
		andLap: -1
		of: jack
		in: twoPlayerGame.
	self
		assertPosition: 4
		andLap: 0
		of: ben
		in: twoPlayerGame
]

{ #category : #tests }
BoxTest >> testSpeedUp [
	| speedUpAndEmpty twoPlayerGame aBoard |
	speedUpAndEmpty := OrderedCollection
		with: empty
		with: empty
		with: empty
		with: speedUp
		with: empty.
	aBoard := Board fromDraft: speedUpAndEmpty andSize: nil.
	twoPlayerGame := Game
		withBoard: aBoard
		withLaps: 1
		withPlayers: players
		with: deckOfCards.
	diceOne nextRollNumber: 2.
	twoPlayerGame newTurnWithDice: diceOne.
	self
		assertPosition: 2
		andLap: 0
		of: jack
		in: twoPlayerGame.
	self
		assertPosition: 0
		andLap: 0
		of: ben
		in: twoPlayerGame.
	diceOne nextRollNumber: 4.
	twoPlayerGame newTurnWithDice: diceOne.
	self
		assertPosition: 2
		andLap: 0
		of: jack
		in: twoPlayerGame.
	self
		assertPosition: 3
		andLap: 1
		of: ben
		in: twoPlayerGame
]

{ #category : #tests }
BoxTest >> testTimeMachine [
	| timeMachineAndEmpty twoPlayerGame aBoard |
	timeMachineAndEmpty := OrderedCollection
		with: empty
		with: empty
		with: timeMachine
		with: empty
		with: empty.
	aBoard := Board fromDraft: timeMachineAndEmpty andSize: nil.
	twoPlayerGame := Game
		withBoard: aBoard
		withLaps: 3
		withPlayers: players
		with: deckOfCards.
	diceOne nextRollNumber: 4.
	twoPlayerGame newTurnWithDice: diceOne.
	diceOne nextRollNumber: 5.
	twoPlayerGame newTurnWithDice: diceOne.
	twoPlayerGame newTurnWithDice: diceOne.
	diceOne nextRollNumber: 6.
	twoPlayerGame newTurnWithDice: diceOne.
	self
		assertPosition: 4
		andLap: 1
		of: jack
		in: twoPlayerGame.
	self
		assertPosition: 1
		andLap: 2
		of: ben
		in: twoPlayerGame.
	diceOne nextRollNumber: 4.
	twoPlayerGame newTurnWithDice: diceOne.
	self
		assertPosition: 4
		andLap: 1
		of: jack
		in: twoPlayerGame.
	self
		assertPosition: 1
		andLap: 2
		of: ben
		in: twoPlayerGame
]

{ #category : #tests }
BoxTest >> testVacio [
	| allEmpty twoPlayerGame aBoard |
	allEmpty := OrderedCollection
		with: empty
		with: empty
		with: empty
		with: empty
		with: empty.
	aBoard := Board fromDraft: allEmpty andSize: nil.
	twoPlayerGame := Game
		withBoard: aBoard
		withLaps: 1
		withPlayers: players
		with: deckOfCards.
	diceOne nextRollNumber: 4.
	twoPlayerGame newTurnWithDice: diceOne.
	self
		assertPosition: 4
		andLap: 0
		of: jack
		in: twoPlayerGame.
	self
		assertPosition: 0
		andLap: 0
		of: ben
		in: twoPlayerGame.
	diceOne nextRollNumber: 6.
	twoPlayerGame newTurnWithDice: diceOne.
	self
		assertPosition: 4
		andLap: 0
		of: jack
		in: twoPlayerGame.
	self
		assertPosition: 1
		andLap: 1
		of: ben
		in: twoPlayerGame
]

{ #category : #tests }
BoxTest >> testWormHole [
	| wormHoleAndEmpty twoPlayerGame aBoard |
	wormHoleAndEmpty := OrderedCollection
		with: empty
		with: empty
		with: empty
		with: empty
		with: wormHole.
	aBoard := Board fromDraft: wormHoleAndEmpty andSize: nil.
	twoPlayerGame := Game
		withBoard: aBoard
		withLaps: 1
		withPlayers: players
		with: deckOfCards.
	diceOne nextRollNumber: 2.
	twoPlayerGame newTurnWithDice: diceOne.
	diceOne nextRollNumber: 4.
	twoPlayerGame newTurnWithDice: diceOne.
	self
		assertPosition: 2
		andLap: 0
		of: jack
		in: twoPlayerGame.
	self
		assertPosition: 4
		andLap: 0
		of: ben
		in: twoPlayerGame.
	diceOne nextRollNumber: 3.
	twoPlayerGame newTurnWithDice: diceOne.
	self
		assertPosition: 1
		andLap: 0
		of: jack
		in: twoPlayerGame.
	self
		assertPosition: 4
		andLap: 0
		of: ben
		in: twoPlayerGame
]
