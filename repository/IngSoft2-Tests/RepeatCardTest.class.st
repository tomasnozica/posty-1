"
Please comment me using the following template inspired by Class Responsibility Collaborator (CRC) design:
""""
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
	#name : #RepeatCardTest,
	#superclass : #TestCase,
	#instVars : [
		'jack',
		'ben',
		'players',
		'diceOne',
		'aBoard',
		'boardBuilder',
		'repeat',
		'cardTypes',
		'deckOfCards'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
RepeatCardTest >> assertPosition: aPosition andLap: aLap for: aPlayer in: aGame. [
	self assert: (aGame positionOf: aPlayer) equals: aPosition.
	self assert: (aGame lapOf: aPlayer) equals: aLap
]

{ #category : #running }
RepeatCardTest >> setUp [
	super setUp.
	jack := Player called: 'Jack'.
	ben := Player called: 'Ben'.
	players := OrderedCollection with: jack with: ben.
	diceOne := SameFaceDice withFaces: 4.
	diceOne nextRollNumber: 4.
	boardBuilder := DeterministicBuilder ofSize: 10.
	repeat := RepeatCard new.
	cardTypes := OrderedCollection new.
	cardTypes add: repeat .
	deckOfCards := DeckOfCards withEffects: cardTypes.
]

{ #category : #tests }
RepeatCardTest >> testRepeatAtomicBombEffect [
	|  twoPlayerGame  |
	boardBuilder addAtomicBomb .
	aBoard := boardBuilder build.
	twoPlayerGame := Game withBoard: aBoard withLaps: 2 withPlayers: players with: deckOfCards.
	twoPlayerGame newTurnWithDice: diceOne.
	diceOne nextRollNumber: 5.
	twoPlayerGame newTurnWithDice: diceOne.
	self assertPosition: 0 andLap: 0 for: jack in: twoPlayerGame.
	self assertPosition: 0 andLap: 0 for: ben in: twoPlayerGame.
	twoPlayerGame thePlayer: jack wantsToUseTheCard: repeat on: ben.
	twoPlayerGame newTurnWithDice: diceOne.
	self assertPosition: 0 andLap: 0 for: jack in: twoPlayerGame.
	self assertPosition: 0 andLap: 0 for: ben in: twoPlayerGame.
]

{ #category : #tests }
RepeatCardTest >> testRepeatEmptyEffect [
	|  twoPlayerGame  |
	boardBuilder addEmptyEffect .
	aBoard := boardBuilder build.
	twoPlayerGame := Game withBoard: aBoard withLaps: 2 withPlayers: players with: deckOfCards.
	twoPlayerGame newTurnWithDice: diceOne.
	twoPlayerGame newTurnWithDice: diceOne.
	twoPlayerGame newTurnWithDice: diceOne.
	twoPlayerGame newTurnWithDice: diceOne.
	twoPlayerGame thePlayer: jack wantsToUseTheCard: repeat on: ben.
	self assertPosition: 8 andLap: 0 for: ben in: twoPlayerGame.
]

{ #category : #tests }
RepeatCardTest >> testRepeatWormHoleEffect [
	|  twoPlayerGame  |
	boardBuilder addWormHole .
	aBoard := boardBuilder build.
	twoPlayerGame := Game withBoard: aBoard withLaps: 2 withPlayers: players with: deckOfCards.
	diceOne nextRollNumber: 3.
	twoPlayerGame newTurnWithDice: diceOne.
	diceOne nextRollNumber: 5.
	twoPlayerGame newTurnWithDice: diceOne.
	self assertPosition: 3 andLap: 0 for: jack in: twoPlayerGame.
	self assertPosition: 1 andLap: 0 for: ben in: twoPlayerGame.
	twoPlayerGame thePlayer: jack wantsToUseTheCard: repeat on: ben.
	twoPlayerGame newTurnWithDice: diceOne.
	self assertPosition: 8 andLap: 0 for: jack in: twoPlayerGame.
	self assertPosition: 0 andLap: -1 for: ben in: twoPlayerGame.
]
