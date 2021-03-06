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
		'setOfDices',
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
	| cardTypes  |
	super setUp.
	jack := Player called: 'Jack'.
	ben := Player called: 'Ben'.
	players := OrderedCollection with: jack with: ben.
	diceOne := SameFaceDice withFaces: 4.
	diceOne nextRollNumber: 4.
	setOfDices := OrderedCollection new.
	setOfDices add: diceOne.
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
	twoPlayerGame newTurnWithDice: setOfDices.
	diceOne nextRollNumber: 5.
	twoPlayerGame newTurnWithDice: setOfDices.
	self assertPosition: 0 andLap: 0 for: jack in: twoPlayerGame.
	self assertPosition: 0 andLap: 0 for: ben in: twoPlayerGame.
	twoPlayerGame thePlayer: jack wantsToUseTheCard: repeat on: ben.
	twoPlayerGame newTurnWithDice: setOfDices.
	self assertPosition: 0 andLap: 0 for: jack in: twoPlayerGame.
	self assertPosition: 0 andLap: 0 for: ben in: twoPlayerGame.
]

{ #category : #tests }
RepeatCardTest >> testRepeatCardEffect [
	|  twoPlayerGame  |
	boardBuilder addCard.
	aBoard := boardBuilder build.
	twoPlayerGame := Game withBoard: aBoard withLaps: 2 withPlayers: players with: deckOfCards.
	diceOne nextRollNumber: 5.
	twoPlayerGame newTurnWithDice: setOfDices.
	diceOne nextRollNumber: 3.
	twoPlayerGame newTurnWithDice: setOfDices.
	twoPlayerGame newTurnWithDice: setOfDices.
	twoPlayerGame thePlayer: ben wantsToUseTheCard: repeat on: jack. 
	self assert: (twoPlayerGame amountOfCardsOf: jack) equals: 4.
	self assert: (twoPlayerGame amountOfCardsOf: ben) equals: 1.
]

{ #category : #tests }
RepeatCardTest >> testRepeatEmptyEffect [
	|  twoPlayerGame  |
	boardBuilder addEmptyEffect .
	aBoard := boardBuilder build.
	twoPlayerGame := Game withBoard: aBoard withLaps: 2 withPlayers: players with: deckOfCards.
	twoPlayerGame newTurnWithDice: setOfDices.
	twoPlayerGame newTurnWithDice: setOfDices.
	twoPlayerGame newTurnWithDice: setOfDices.
	twoPlayerGame newTurnWithDice: setOfDices.
	twoPlayerGame thePlayer: jack wantsToUseTheCard: repeat on: ben.
	self assertPosition: 8 andLap: 0 for: ben in: twoPlayerGame.
]

{ #category : #tests }
RepeatCardTest >> testRepeatMoonWalk [
	|  twoPlayerGame  |
	boardBuilder addMoonWalk .
	aBoard := boardBuilder build.
	twoPlayerGame := Game withBoard: aBoard withLaps: 2 withPlayers: players with: deckOfCards.
	diceOne nextRollNumber: 8.
	twoPlayerGame newTurnWithDice: setOfDices.
	diceOne nextRollNumber: 5.
	twoPlayerGame newTurnWithDice: setOfDices.
	self assertPosition: 6 andLap: 0 for: jack in: twoPlayerGame.
	self assertPosition: 5 andLap: 0 for: ben in: twoPlayerGame.
	diceOne nextRollNumber: 3.
	twoPlayerGame newTurnWithDice: setOfDices.
	twoPlayerGame newTurnWithDice: setOfDices.
	twoPlayerGame thePlayer: jack wantsToUseTheCard: repeat on: ben.
	self assertPosition: 9 andLap: 0 for: jack in: twoPlayerGame.
	self assertPosition: 6  andLap: 0 for: ben in: twoPlayerGame.
]

{ #category : #tests }
RepeatCardTest >> testRepeatSpeedUp [
	|  twoPlayerGame  |
	boardBuilder addSpeedUp .
	aBoard := boardBuilder build.
	twoPlayerGame := Game withBoard: aBoard withLaps: 2 withPlayers: players with: deckOfCards.
	diceOne nextRollNumber: 3.
	twoPlayerGame newTurnWithDice: setOfDices.
	diceOne nextRollNumber: 5.
	twoPlayerGame newTurnWithDice: setOfDices.
	self assertPosition: 3 andLap: 0 for: jack in: twoPlayerGame.
	self assertPosition: 9 andLap: 0 for: ben in: twoPlayerGame.
	twoPlayerGame thePlayer: jack wantsToUseTheCard: repeat on: ben.
	twoPlayerGame newTurnWithDice: setOfDices.
	self assertPosition: 8 andLap: 0 for: jack in: twoPlayerGame.
	self assertPosition: 3 andLap: 1 for: ben in: twoPlayerGame.
]

{ #category : #tests }
RepeatCardTest >> testRepeatWormHoleEffect [
	|  twoPlayerGame  |
	boardBuilder addWormHole .
	aBoard := boardBuilder build.
	twoPlayerGame := Game withBoard: aBoard withLaps: 2 withPlayers: players with: deckOfCards.
	diceOne nextRollNumber: 3.
	twoPlayerGame newTurnWithDice: setOfDices.
	diceOne nextRollNumber: 5.
	twoPlayerGame newTurnWithDice: setOfDices.
	self assertPosition: 3 andLap: 0 for: jack in: twoPlayerGame.
	self assertPosition: 1 andLap: 0 for: ben in: twoPlayerGame.
	twoPlayerGame thePlayer: jack wantsToUseTheCard: repeat on: ben.
	twoPlayerGame newTurnWithDice: setOfDices.
	self assertPosition: 8 andLap: 0 for: jack in: twoPlayerGame.
	self assertPosition: 0 andLap: -1 for: ben in: twoPlayerGame.
]
