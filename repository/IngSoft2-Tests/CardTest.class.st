"
Please comment me using the following template inspired by Class Responsibility Collaborator (CRC) design:

For the Class part:  State a one line summary. For example, ""I represent a paragraph of text"".
""Testing card behaviour""
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
	#name : #CardTest,
	#superclass : #TestCase,
	#instVars : [
		'players',
		'jack',
		'ben',
		'theGame',
		'empty',
		'boxes',
		'aBoard',
		'threePlayerGame',
		'diceOne',
		'diceTwo',
		'card',
		'boardBuilder'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
CardTest >> assertPosition: aPosition andLap: aLap for: aPlayer in: aGame. [
	self assert: (aGame positionOf: aPlayer) equals: aPosition.
	self assert: (aGame lapOf: aPlayer) equals: aLap
]

{ #category : #running }
CardTest >> setUp [
	super setUp.
	jack := Player called: 'Jack'.
	ben := Player called: 'Ben'.
	players := OrderedCollection with: jack with: ben.
	diceOne := SameFaceDice withFaces: 4.
	diceOne nextRollNumber: 4.
	diceTwo := SameFaceDice withFaces: 5.
	boardBuilder := UCAGameBoardBuilder ofSize: 10.
	boardBuilder addEmptyEffect .
	aBoard := boardBuilder build.
	






]

{ #category : #tests }
CardTest >> testAcceleration [
	| acceleration deckOfCards twoPlayerGame cardTypes |
	acceleration := AccelerationCard new.
	cardTypes := OrderedCollection new.
	cardTypes add: acceleration .
	deckOfCards := DeckOfCards withEffects: cardTypes.
	twoPlayerGame := Game withBoard: aBoard withLaps: 2 withPlayers: players with: deckOfCards.
	twoPlayerGame thePlayer: jack wantsToUseTheCard: acceleration on: players.
	diceOne nextRollNumber: 4.
	twoPlayerGame newTurnWithDice: diceOne.
	twoPlayerGame newTurnWithDice: diceOne.
	self assertPosition: 5 andLap: 0 for: jack in: twoPlayerGame.
	self assertPosition: 5 andLap: 0 for: ben in: twoPlayerGame.
]

{ #category : #tests }
CardTest >> testAnyRandomCardIPickIsOneOfTheTypesGiven [
	| cardTypes overload speed acceleration cancellation redo repeat deckOfCards aCard |
	overload := OverloadCard new.
	speed := SpeedCard new.
	acceleration := AccelerationCard new.
	cancellation := CancellationCard new.
	redo := RedoCard new.
	repeat := RepeatCard new.
	cardTypes := OrderedCollection with: overload with: speed with: acceleration with: cancellation with: redo with: repeat.
	deckOfCards := DeckOfCards withEffects: cardTypes .
	aCard := deckOfCards pickACard.
	self assert: (cardTypes anySatisfy: [ :anEffect | anEffect = aCard ] )
]

{ #category : #tests }
CardTest >> testCancellation [
	| cardTypes acceleration cancellation deckOfCards twoPlayerGame |
	acceleration := AccelerationCard new.
	cancellation := CancellationCard new.
	cardTypes := OrderedCollection with:acceleration with:cancellation .
	deckOfCards := DeckOfCards withEffects: cardTypes.
	twoPlayerGame := Game withBoard: aBoard withLaps: 2 withPlayers: players with: deckOfCards.
	twoPlayerGame thePlayer: jack willHaveTheCards: (OrderedCollection with: acceleration with: cancellation).
	twoPlayerGame thePlayer: jack wantsToUseTheCard: acceleration on: players.
	diceOne nextRollNumber: 4.
	twoPlayerGame newTurnWithDice: diceOne.
	self assertPosition: 5 andLap: 0 for: jack in: twoPlayerGame.
	twoPlayerGame newTurnWithDice: diceOne.
	twoPlayerGame thePlayer: jack wantsToUseTheCard: cancellation  on: acceleration .
	twoPlayerGame newTurnWithDice: diceOne.
	self assertPosition: 9 andLap: 0 for: jack in: twoPlayerGame.
	
]

{ #category : #tests }
CardTest >> testOverload [
	| overload deckOfCards twoPlayerGame cardTypes |
	overload := OverloadCard new.
	cardTypes := OrderedCollection new.
	cardTypes add: overload  .
	deckOfCards := DeckOfCards withEffects: cardTypes.
	twoPlayerGame := Game withBoard: aBoard withLaps: 2 withPlayers: players with: deckOfCards.
	twoPlayerGame thePlayer: jack wantsToUseTheCard: overload on: ben.
	diceOne nextRollNumber: 4.
	twoPlayerGame newTurnWithDice: diceOne.
	twoPlayerGame newTurnWithDice: diceOne.
	self assertPosition: 4 andLap: 0 for: jack in: twoPlayerGame.
	self assertPosition: 2 andLap: 0 for: ben in: twoPlayerGame.
]

{ #category : #tests }
CardTest >> testRedoPermanentCard [
	| speed redo deckOfCards twoPlayerGame cardTypes |
	speed := SpeedCard new.
	redo := RedoCard new.
	cardTypes := OrderedCollection with: speed with:redo.
	deckOfCards := DeckOfCards withEffects: cardTypes.
	twoPlayerGame := Game withBoard: aBoard withLaps: 2 withPlayers: players with: deckOfCards.
	twoPlayerGame thePlayer: jack wantsToUseTheCard: speed on: ben.
	diceOne nextRollNumber: 2.
	twoPlayerGame newTurnWithDice: diceOne. "jack"
	twoPlayerGame newTurnWithDice: diceOne. "ben"
	self assertPosition: 2 andLap: 0 for: jack in: twoPlayerGame.
	self assertPosition: 3 andLap: 0 for: ben in: twoPlayerGame.
	twoPlayerGame newTurnWithDice: diceOne. "jack"
	self assertPosition: 4 andLap: 0  for: jack in: twoPlayerGame . 
	twoPlayerGame thePlayer: ben wantsToUseTheCard: redo on: jack.
	twoPlayerGame newTurnWithDice: diceOne. "ben"
	twoPlayerGame newTurnWithDice: diceOne. 
	self assertPosition: 7 andLap: 0  for: jack in: twoPlayerGame . 
]

{ #category : #tests }
CardTest >> testRepeat [
	self assert: true.
]

{ #category : #tests }
CardTest >> testSpeed [
	| speed deckOfCards twoPlayerGame cardTypes |
	speed := SpeedCard new.
	cardTypes := OrderedCollection new.
	cardTypes add: speed  .
	deckOfCards := DeckOfCards withEffects: cardTypes.
	twoPlayerGame := Game withBoard: aBoard withLaps: 2 withPlayers: players with: deckOfCards.
	twoPlayerGame thePlayer: jack wantsToUseTheCard: speed on: ben.
	diceOne nextRollNumber: 4.
	twoPlayerGame newTurnWithDice: diceOne.
	twoPlayerGame newTurnWithDice: diceOne.
	self assertPosition: 4 andLap: 0 for: jack in: twoPlayerGame.
	self assertPosition: 5 andLap: 0 for: ben in: twoPlayerGame.
]
