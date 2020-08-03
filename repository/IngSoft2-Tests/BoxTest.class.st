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
		'diceOne',
		'jack',
		'ben',
		'players',
		'deckOfCards',
		'setOfDices'
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
	| theBlanckCard theNoEffectCards |
	super setUp.
	diceOne := SameFaceDice withFaces: 6.
	setOfDices := OrderedCollection new.
	setOfDices add: diceOne.
	jack := Player called: 'Jack'.
	ben := Player called: 'Ben'.
	players := OrderedCollection with: jack with: ben.
	theBlanckCard := BlankCard new.
	theNoEffectCards := OrderedCollection with: theBlanckCard  with: theBlanckCard .
	deckOfCards := DeckOfCards withEffects: theNoEffectCards
]

{ #category : #tests }
BoxTest >> testAtomicBomb [
	| board game |
	board := UCAGameBoardBuilder ofSize: 5.
	board addAtomicBomb.
	game := Game withBoard: (board build) withLaps: 1 withPlayers: players with: deckOfCards.
	self assertPosition: 0 andLap: 0 of: jack in: game.
	diceOne nextRollNumber: 2.
	game newTurnWithDice: setOfDices .
	self assertPosition: 0 andLap: 0 of: jack in: game.
	




]

{ #category : #tests }
BoxTest >> testMoonWalk [
	| draft game stepsBack board|
	draft := UCAGameBoardBuilder ofSize: 10.
	draft addMoonWalk  .
	board := draft build.
	game := Game withBoard: board withLaps: 1 withPlayers: players with: deckOfCards.
	diceOne nextRollNumber: 6.
	game newTurnWithDice: setOfDices .
	diceOne nextRollNumber: 3.
	game newTurnWithDice: setOfDices .
	stepsBack := (board positionAt: 3) stepsBack.
	self assertPosition: 6-stepsBack andLap: 0 of: jack in: game.
]

{ #category : #tests }
BoxTest >> testSpeedUp [
	| board game |
	board := UCAGameBoardBuilder ofSize: 10.
	board addSpeedUp .
	game := Game withBoard: (board build) withLaps: 1 withPlayers: players with: deckOfCards.
	self assertPosition: 0 andLap: 0 of: jack in: game.
	diceOne nextRollNumber: 2.
	game newTurnWithDice: setOfDices .
	self assertPosition: 6 andLap: 0 of: jack in: game.
		
	












]

{ #category : #tests }
BoxTest >> testVacio [
	| board game |
	board := UCAGameBoardBuilder ofSize: 10.
	board addEmptyEffect.
	game := Game withBoard: (board build) withLaps: 1 withPlayers: players with: deckOfCards.
	self assertPosition: 0 andLap: 0 of: jack in: game.
	diceOne nextRollNumber: 2.
	game newTurnWithDice: setOfDices .
	self assertPosition: 2 andLap: 0 of: jack in: game.
		
]

{ #category : #tests }
BoxTest >> testWormHole [
	| board game |
	board := UCAGameBoardBuilder ofSize: 10.
	board addWormHole.
	game := Game withBoard: (board build) withLaps: 1 withPlayers: players with: deckOfCards.
	self assertPosition: 0 andLap: 0 of: jack in: game.
	diceOne nextRollNumber: 6.
	game newTurnWithDice: setOfDices .
	self assertPosition: 2 andLap: 0 of: jack in: game.
	
]
