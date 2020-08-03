"
Please comment me using the following template inspired by Class Responsibility Collaborator (CRC) design:
""Testing the redo card""
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
	#name : #RedoCardTest,
	#superclass : #TestCase,
	#instVars : [
		'jack',
		'ben',
		'players',
		'diceOne',
		'acceleration',
		'cancellation',
		'overload',
		'redo',
		'twoPlayerGame',
		'speed',
		'setOfDices'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
RedoCardTest >> assertPosition: aPosition andLap: aLap for: aPlayer in: aGame. [
	self assert: (aGame positionOf: aPlayer) equals: aPosition.
	self assert: (aGame lapOf: aPlayer) equals: aLap
]

{ #category : #running }
RedoCardTest >> setUp [
	| boardBuilder aBoard  cardTypes deckOfCards |
	super setUp.
	jack := Player called: 'Jack'.
	ben := Player called: 'Ben'.
	players := OrderedCollection with: jack with: ben.
	diceOne := SameFaceDice withFaces: 4.
	setOfDices := OrderedCollection new.
	setOfDices add: diceOne.
	boardBuilder := DeterministicBuilder ofSize: 10.
	boardBuilder addEmptyEffect .
	aBoard := boardBuilder build.
	acceleration := AccelerationCard new.
	cancellation := CancellationCard new.
	overload := OverloadCard new.
	redo := RedoCard new.
	speed := SpeedCard new.
	cardTypes := OrderedCollection with: acceleration  with: cancellation with: overload with: redo with:speed. 
	deckOfCards := DeckOfCards withEffects: cardTypes.
	twoPlayerGame := Game withBoard: aBoard withLaps: 2 withPlayers: players with: deckOfCards.
]

{ #category : #tests }
RedoCardTest >> testRedoAcceleration [
	twoPlayerGame thePlayer: jack willHaveTheCards: (OrderedCollection with: acceleration with: acceleration).
	twoPlayerGame thePlayer: ben willHaveTheCards: (OrderedCollection with: redo with: redo).
	twoPlayerGame thePlayer: jack wantsToUseTheCard: acceleration on: ben.
	diceOne nextRollNumber: 2.
	twoPlayerGame newTurnWithDice: setOfDices. "jack"
	twoPlayerGame newTurnWithDice: setOfDices. "ben"
	self assertPosition: 2 andLap: 0 for: jack in: twoPlayerGame.
	self assertPosition: 3 andLap: 0 for: ben in: twoPlayerGame.
	twoPlayerGame newTurnWithDice: setOfDices. "jack"
	self assertPosition: 4 andLap: 0  for: jack in: twoPlayerGame . 
	twoPlayerGame thePlayer: ben wantsToUseTheCard: redo on: players.
	twoPlayerGame newTurnWithDice: setOfDices. "ben"
	twoPlayerGame newTurnWithDice: setOfDices. 
	self assertPosition: 7 andLap: 0  for: jack in: twoPlayerGame .
	self assertPosition: 7 andLap: 0  for: ben in: twoPlayerGame .  
]

{ #category : #tests }
RedoCardTest >> testRedoCancellationCard [
	twoPlayerGame thePlayer: jack willHaveTheCards: (OrderedCollection with: acceleration with: cancellation).
	twoPlayerGame thePlayer: ben willHaveTheCards: (OrderedCollection with: redo with: acceleration).
	twoPlayerGame thePlayer: jack wantsToUseTheCard: acceleration on: players.
	diceOne nextRollNumber: 2.
	twoPlayerGame newTurnWithDice: setOfDices.
	self assertPosition: 3 andLap: 0 for: jack in: twoPlayerGame.
	self assertPosition: 0 andLap: 0 for: ben in: twoPlayerGame.
	twoPlayerGame thePlayer: ben wantsToUseTheCard: acceleration on: players.
	twoPlayerGame newTurnWithDice: setOfDices.
	self assertPosition: 3 andLap: 0 for: jack in: twoPlayerGame.
	self assertPosition: 4 andLap: 0 for: ben in: twoPlayerGame.
	twoPlayerGame thePlayer: jack wantsToUseTheCard: cancellation  on: acceleration .
	twoPlayerGame newTurnWithDice: setOfDices.
	self assertPosition: 6 andLap: 0 for: jack in: twoPlayerGame.
	self assertPosition: 4 andLap: 0 for: ben in: twoPlayerGame.
	twoPlayerGame thePlayer: ben wantsToUseTheCard: redo  on: acceleration.
	twoPlayerGame newTurnWithDice: setOfDices.
	self assertPosition: 6 andLap: 0 for: ben in: twoPlayerGame.
]

{ #category : #tests }
RedoCardTest >> testRedoOverloadCard [
	twoPlayerGame thePlayer: jack willHaveTheCards: (OrderedCollection with: overload with: overload).
	twoPlayerGame thePlayer: ben willHaveTheCards: (OrderedCollection with: redo with: redo).
	twoPlayerGame thePlayer: jack wantsToUseTheCard: overload on: ben.
	diceOne nextRollNumber: 3.
	twoPlayerGame newTurnWithDice: setOfDices.
	twoPlayerGame newTurnWithDice: setOfDices.
	self assertPosition: 3 andLap: 0 for: jack in: twoPlayerGame.
	self assertPosition: 1 andLap: 0 for: ben in: twoPlayerGame.
	twoPlayerGame newTurnWithDice: setOfDices.
	self assertPosition: 6 andLap: 0  for: jack in: twoPlayerGame . 
	twoPlayerGame thePlayer: ben wantsToUseTheCard: redo on: jack.
	twoPlayerGame newTurnWithDice: setOfDices.
	twoPlayerGame newTurnWithDice: setOfDices. 
	self assertPosition: 7 andLap: 0  for: jack in: twoPlayerGame . 
]

{ #category : #tests }
RedoCardTest >> testRedoSpeedCard [
	twoPlayerGame thePlayer: jack willHaveTheCards: (OrderedCollection with: speed with: speed).
	twoPlayerGame thePlayer: ben willHaveTheCards: (OrderedCollection with: redo with: redo).
	twoPlayerGame thePlayer: jack wantsToUseTheCard: speed on: ben.
	diceOne nextRollNumber: 2.
	twoPlayerGame newTurnWithDice: setOfDices.
	twoPlayerGame newTurnWithDice: setOfDices.
	self assertPosition: 2 andLap: 0 for: jack in: twoPlayerGame.
	self assertPosition: 3 andLap: 0 for: ben in: twoPlayerGame.
	twoPlayerGame newTurnWithDice: setOfDices.
	self assertPosition: 4 andLap: 0  for: jack in: twoPlayerGame . 
	twoPlayerGame thePlayer: ben wantsToUseTheCard: redo on: jack.
	twoPlayerGame newTurnWithDice: setOfDices.
	twoPlayerGame newTurnWithDice: setOfDices. 
	self assertPosition: 7 andLap: 0  for: jack in: twoPlayerGame . 
]
