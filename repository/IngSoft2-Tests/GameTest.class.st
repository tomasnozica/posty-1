"
Please comment me using the following template inspired by Class Responsibility Collaborator (CRC) design:
""Test game behavior ""
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
	#name : #GameTest,
	#superclass : #TestCase,
	#instVars : [
		'jack',
		'ben',
		'twoPlayerGame',
		'diceOne',
		'diceTwo',
		'theBlanckCard',
		'setOfDices'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
GameTest >> assertLastPosition: aPosition andLastLap: aLap for: aPlayer in: aGame [ 
	self assert: (aGame lastPositionOf: aPlayer) equals: aPosition.
	self assert: (aGame lastLapOf: aPlayer) equals: aLap.
]

{ #category : #asserting }
GameTest >> assertPosition: aPosition andLap: aLap for: aPlayer in: aGame. [
	self assert: (aGame positionOf: aPlayer) equals: aPosition.
	self assert: (aGame lapOf: aPlayer) equals: aLap
]

{ #category : #running }
GameTest >> setUp [
	| cardTypes deckOfCards players aBoard boardBuilder|
	super setUp.
	jack := Player called: 'Jack'.
	ben := Player called: 'Ben'.
	players := OrderedCollection with: jack with: ben.
	diceOne := SameFaceDice withFaces: 4.
	diceOne nextRollNumber: 4.
	setOfDices := OrderedCollection new.
	setOfDices add: diceOne.
	diceTwo := SameFaceDice withFaces: 5.
	boardBuilder := DeterministicBuilder ofSize: 10.
	boardBuilder addEmptyEffect .
	aBoard := boardBuilder build.
	cardTypes := OrderedCollection new.
	theBlanckCard := BlankCard new.
	cardTypes add: theBlanckCard.
	deckOfCards := DeckOfCards withEffects: cardTypes .
	twoPlayerGame := Game withBoard: aBoard withLaps: 2 withPlayers: players with: deckOfCards.



]

{ #category : #tests }
GameTest >> testAfterJackPlaysItsBenTurn [
	self assert: twoPlayerGame currentPlayer equals: jack.
	twoPlayerGame newTurnWithDice: setOfDices.
	self assert: twoPlayerGame currentPlayer equals: ben.
]

{ #category : #tests }
GameTest >> testAtTheBeginingEachPlayerHasTwoCards [
	self assert: (twoPlayerGame amountOfCardsOf: jack) equals: 2.
	self assert: (twoPlayerGame amountOfCardsOf: ben) equals: 2.
]

{ #category : #tests }
GameTest >> testGameIsOver [
	diceOne nextRollNumber: 9.
	twoPlayerGame newTurnWithDice: setOfDices.
	diceOne nextRollNumber: 5.
	twoPlayerGame newTurnWithDice: setOfDices.
	diceOne nextRollNumber: 8.
	twoPlayerGame newTurnWithDice: setOfDices.
	diceOne nextRollNumber: 5.
	twoPlayerGame newTurnWithDice: setOfDices.
	diceOne nextRollNumber: 4.
	twoPlayerGame newTurnWithDice: setOfDices.
	self assert: twoPlayerGame isOver.
]

{ #category : #tests }
GameTest >> testJackAndBenArePlayersOfTheGame [
	self assert:  (twoPlayerGame isAPlayer: jack).
	self assert:  (twoPlayerGame isAPlayer: ben).
]

{ #category : #tests }
GameTest >> testJackPlaysAndChangePosition [
	self assertPosition: 0 andLap: 0  for: jack  in: twoPlayerGame. 
	diceOne nextRollNumber: 4.
	twoPlayerGame newTurnWithDice: setOfDices.
	self assertPosition: 4 andLap: 0  for: jack  in: twoPlayerGame. 
]

{ #category : #tests }
GameTest >> testLastPositionOfJack [
	diceOne nextRollNumber: 4.
	twoPlayerGame newTurnWithDice: setOfDices.
	twoPlayerGame newTurnWithDice: setOfDices.
	twoPlayerGame newTurnWithDice: setOfDices.
	self assertPosition: 8 andLap: 0  for: jack in: twoPlayerGame.
	twoPlayerGame newTurnWithDice: setOfDices.
	twoPlayerGame newTurnWithDice: setOfDices.
	self assertLastPosition: 8 andLastLap: 0 for: jack in: twoPlayerGame.
]

{ #category : #tests }
GameTest >> testNoOneCanPlayAfterGameIsOver [
	diceOne nextRollNumber: 9.
	twoPlayerGame newTurnWithDice: setOfDices.
	diceOne nextRollNumber: 5.
	twoPlayerGame newTurnWithDice: setOfDices.
	diceOne nextRollNumber: 8.
	twoPlayerGame newTurnWithDice: setOfDices.
	diceOne nextRollNumber: 5.
	twoPlayerGame newTurnWithDice: setOfDices.
	diceOne nextRollNumber: 4.
	twoPlayerGame newTurnWithDice: setOfDices.
	self should: [ twoPlayerGame newTurnWithDice: setOfDices ] raise: Error.
]

{ #category : #tests }
GameTest >> testPlayerCompletesALap [
	diceOne nextRollNumber: 5.
	twoPlayerGame newTurnWithDice: setOfDices.
	diceOne nextRollNumber: 5.
	twoPlayerGame newTurnWithDice: setOfDices.
	diceOne nextRollNumber: 6.
	twoPlayerGame newTurnWithDice: setOfDices.
	self assertPosition: 1 andLap: 1  for: jack  in: twoPlayerGame. 
]

{ #category : #tests }
GameTest >> testPlayerPlaysPositionChange [
	self assertPosition: 0 andLap: 0  for: jack  in: twoPlayerGame. 
	self assertPosition: 0 andLap: 0  for: ben  in: twoPlayerGame . 
	diceOne nextRollNumber: 4.
	twoPlayerGame newTurnWithDice: setOfDices. 
	diceOne nextRollNumber: 6.
	twoPlayerGame newTurnWithDice: setOfDices.
	self assertPosition: 4 andLap: 0  for: jack  in: twoPlayerGame. 
	self assertPosition: 6 andLap: 0  for: ben  in: twoPlayerGame . 
]

{ #category : #tests }
GameTest >> testPlayerPlaysWithDifferentDices [
	| dices |
	diceOne nextRollNumber: 3.
	diceTwo nextRollNumber: 2.
	dices := OrderedCollection with: diceOne with:diceTwo .
	twoPlayerGame newTurnWithDice: dices.
	diceTwo nextRollNumber: 4.
	twoPlayerGame newTurnWithDice: dices.
	self assertPosition: 5 andLap: 0 for: jack in: twoPlayerGame.
	self assertPosition: 7 andLap: 0 for: ben in: twoPlayerGame.
]

{ #category : #tests }
GameTest >> testStepsOfAGame [
	self assert: twoPlayerGame steps equals: 10. 
]

{ #category : #tests }
GameTest >> testTheRankingOfTheGame [
	diceOne nextRollNumber: 5.
	twoPlayerGame newTurnWithDice: setOfDices.
	diceOne nextRollNumber: 6.
	twoPlayerGame  newTurnWithDice: setOfDices.
	self assert: (twoPlayerGame  rankingPositionOf: jack) equals: 2.
	self assert: (twoPlayerGame  rankingPositionOf: ben) equals: 1.
]

{ #category : #tests }
GameTest >> testTheWinnerOfTheGame [
	diceOne nextRollNumber: 9.
	twoPlayerGame newTurnWithDice: setOfDices.
	diceOne nextRollNumber: 5.
	twoPlayerGame newTurnWithDice: setOfDices.
	diceOne nextRollNumber: 8.
	twoPlayerGame newTurnWithDice: setOfDices.
	diceOne nextRollNumber: 5.
	twoPlayerGame newTurnWithDice: setOfDices.
	diceOne nextRollNumber: 4.
	twoPlayerGame newTurnWithDice: setOfDices.
	self assert: twoPlayerGame winner equals: jack.
]
