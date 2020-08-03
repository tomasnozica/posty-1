"
Please comment me using the following template inspired by Class Responsibility Collaborator (CRC) design:
""""""
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
	#name : #JailBoxTest,
	#superclass : #TestCase,
	#instVars : [
		'jack',
		'ben',
		'players',
		'diceOne',
		'boardBuilder',
		'freedom',
		'cardTypes',
		'deckOfCards',
		'aBoard',
		'setOfDices',
		'diceTwo'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
JailBoxTest >> assertPosition: aPosition andLap: aLap of: aPlayer in: theGame [ 
	self assert: (theGame positionOf: aPlayer) equals: aPosition.
	self assert: (theGame lapOf: aPlayer) equals: aLap
]

{ #category : #running }
JailBoxTest >> setUp [
	super setUp.
	jack := Player called: 'Jack'.
	ben := Player called: 'Ben'.
	players := OrderedCollection with: jack with: ben.
	diceOne := SameFaceDice withFaces: 6.
	diceOne nextRollNumber: 4.
	setOfDices := OrderedCollection new.
	setOfDices add: diceOne.
	diceTwo:= SameFaceDice withFaces: 5.
	diceTwo nextRollNumber: 5.
	boardBuilder := DeterministicBuilder ofSize: 10.
	freedom := FreedomCard new.
	cardTypes := OrderedCollection new.
	cardTypes add: freedom .
	deckOfCards := DeckOfCards withEffects: cardTypes.
]

{ #category : #tests }
JailBoxTest >> testFreedomWithCard [
	|  twoPlayerGame  |
	boardBuilder addJailEffect .
	aBoard := boardBuilder build.
	twoPlayerGame := Game withBoard: aBoard withLaps: 2 withPlayers: players with: deckOfCards.
	diceOne nextRollNumber: 5.
	twoPlayerGame newTurnWithDice: setOfDices .
	diceOne nextRollNumber: 3.
	twoPlayerGame newTurnWithDice: setOfDices.
	diceOne nextRollNumber: 4.
	twoPlayerGame thePlayer: jack wantsToUseTheCard: freedom on: jack.
	twoPlayerGame newTurnWithDice: setOfDices.
	self assertPosition: 9 andLap: 0  of: jack  in: twoPlayerGame . 
]

{ #category : #tests }
JailBoxTest >> testFreedomWithDice [
	|  twoPlayerGame  |
	boardBuilder addJailEffect .
	aBoard := boardBuilder build.
	twoPlayerGame := Game withBoard: aBoard withLaps: 2 withPlayers: players with: deckOfCards.
	diceOne nextRollNumber: 5.
	twoPlayerGame newTurnWithDice: setOfDices.
	diceOne nextRollNumber: 3.
	twoPlayerGame newTurnWithDice: setOfDices.
	diceOne nextRollNumber: 6.
	twoPlayerGame newTurnWithDice: setOfDices.
	self assertPosition: 1 andLap: 1  of: jack  in: twoPlayerGame . 
]

{ #category : #tests }
JailBoxTest >> testFreedomWithManyDices [
	|  twoPlayerGame dice |
	dice := OrderedCollection with: diceOne with: diceTwo .
	boardBuilder addJailEffect .
	aBoard := boardBuilder build.
	twoPlayerGame := Game withBoard: aBoard withLaps: 2 withPlayers: players with: deckOfCards.
	diceOne nextRollNumber: 5.
	twoPlayerGame newTurnWithDice: setOfDices.
	diceOne nextRollNumber: 3.
	twoPlayerGame newTurnWithDice: setOfDices.
	diceOne nextRollNumber: 6.
	diceTwo nextRollNumber: 5.
	twoPlayerGame newTurnWithDice: dice.
	self assertPosition: 6 andLap: 1  of: jack  in: twoPlayerGame . 
]

{ #category : #tests }
JailBoxTest >> testPlayerRemainsInJail [
	|  twoPlayerGame  |
	boardBuilder addJailEffect .
	aBoard := boardBuilder build.
	twoPlayerGame := Game withBoard: aBoard withLaps: 2 withPlayers: players with: deckOfCards.
	diceOne nextRollNumber: 5.
	twoPlayerGame newTurnWithDice: setOfDices.
	diceOne nextRollNumber: 3.
	twoPlayerGame newTurnWithDice: setOfDices.
	diceOne nextRollNumber: 4.
	self assertPosition: 5 andLap: 0  of: jack  in: twoPlayerGame . 
]
