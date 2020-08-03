"
Please comment me using the following template inspired by Class Responsibility Collaborator (CRC) design:

""Im the board game""
For the Class part:  State a one line summary. For example, ""I represent a paragraph of text"".

For the Responsibility part: Three sentences about my main responsibilities - what I do, what I know.

For the Collaborators Part: State my main collaborators and one line about how I interact with them. 

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	numberOfPlayers:		<Object>
	numberOfStepsToWin:		<Object>
	position:		<Object>
	stepsToWin:		<Object>


    Implementation Points
"
Class {
	#name : #Game,
	#superclass : #Object,
	#instVars : [
		'numberOfLaps',
		'listOfPlayers',
		'board',
		'turnManager',
		'deckOfCards',
		'playersOfTheGame',
		'lastCardUsed',
		'permanentCards'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #creation }
Game class >> assertIsAPositiveNumber: aNumber [
	aNumber > 0
		ifFalse: [ self error: 'Invalid' ]
	
]

{ #category : #creation }
Game class >> withBoard: aBoard withLaps: aNumberOfLaps withPlayers: players with: deckOfCards [ 
	self assertIsAPositiveNumber: aBoard amountOfBoxes.
	self assertIsAPositiveNumber: aNumberOfLaps.
	self assertIsAPositiveNumber: players size.
	^ self new 
		initializeWithBoard: aBoard
		withLaps: aNumberOfLaps
		withPlayers: players
		with: deckOfCards ;
		yourself
]

{ #category : #actions }
Game >> addCardToPlayer: aPlayer [ 
	playersOfTheGame addCard: (deckOfCards pickACard) toPlayer: aPlayer
]

{ #category : #adding }
Game >> addPermanentCard: aCard [
	permanentCards add: aCard
]

{ #category : #description }
Game >> amountOfCardsOf: aPlayer [ 
	^ playersOfTheGame amountOfCardsOf: aPlayer.
]

{ #category : #'effect of cards' }
Game >> applyCardTo: aPlayer [
	| a |
	a := permanentCards select: [ :aPermanentCard | ((aPermanentCard player = listOfPlayers ) | (aPermanentCard player = aPlayer) ) ].
	a isEmpty ifFalse: [ ^ (a collect: [ :each | each effect ]) sum ] ifTrue: [ ^0 ].
	
]

{ #category : #asserting }
Game >> assertGameIsOver [
	self isOver
		ifTrue: [ self error: 'The game has ended' ]
]

{ #category : #asserting }
Game >> assertIsInJail: aPlayer [
	(playersOfTheGame isFree: aPlayer ) ifFalse: [ self error: 'Estas en la carcel' ].
]

{ #category : #asserting }
Game >> assertIsTheTurnOf: aPlayer [
	aPlayer = self currentPlayer
		ifFalse: [ self error: 'Not your turn' ]
]

{ #category : #creation }
Game >> createCardsOfPlayer: aListOfPlayers [
	^ aListOfPlayers
		collect:
			[ :player | CardsOfAPlayer player: player cards: self pickTwoRandomCards ]
]

{ #category : #'jail actions' }
Game >> createFreedomOfPlayer: aListOfPlayers [
	^ aListOfPlayers
		collect:
			[ :player | FreedomOfAPlayer player: player ]
]

{ #category : #creation }
Game >> createPlayersOfAGame: aListOfPlayers [
	playersOfTheGame := PlayersOfAGame
		positions: (self createPositionRecords: aListOfPlayers)
		cards: (self createCardsOfPlayer: aListOfPlayers)
		permanentCards: nil
		freedom: (self createFreedomOfPlayer: aListOfPlayers )
]

{ #category : #creation }
Game >> createPositionRecords: aListOfPlayers [
	^ aListOfPlayers collect: [ :player | PositionRecord ofPlayer: player]
]

{ #category : #description }
Game >> currentPlayer [
	^ listOfPlayers  at: turnManager returnTurn.
]

{ #category : #'effect of cards' }
Game >> doEffectOnLastPositionOf: aPlayer [
	board doEffectOnLastPosition: aPlayer in: self.
	
]

{ #category : #testing }
Game >> has: aSetOfDices gaveMaxValue: aNumber [
	| maxValue |
	maxValue := (aSetOfDices collect: [ :aDice | aDice faces ]) sum.
	maxValue == aNumber ifTrue: [ self setFreeFromJail: (self currentPlayer ) ].
]

{ #category : #initializing }
Game >> initializeWithBoard: aBoard withLaps: aNumberOfLaps withPlayers: players with: aDeckOfCards [ 
	board := aBoard.
	numberOfLaps := aNumberOfLaps.
	turnManager := AssignTurn withAmountOfPlayers: players size.
	listOfPlayers := players.
	deckOfCards := aDeckOfCards .
	permanentCards := OrderedCollection new.
	self createPlayersOfAGame: players.
]

{ #category : #description }
Game >> isAPlayer: aPlayer [ 
	^ (playersOfTheGame allPlayers) anySatisfy: [ :player | player = aPlayer ]
]

{ #category : #asserting }
Game >> isOver [
	^ playersOfTheGame hasAnyPlayerReachedPosition: (numberOfLaps * (board amountOfBoxes)) .
]

{ #category : #positions }
Game >> lapOf: aPlayer [ 
	^ board lapAccordingToBoard: (playersOfTheGame positionRecordsOf: aPlayer) position .
]

{ #category : #accessing }
Game >> lastCardUsed [
	^ lastCardUsed
]

{ #category : #accessing }
Game >> lastCardUsed: aCard [
	lastCardUsed := aCard.
]

{ #category : #accessing }
Game >> lastLapOf: aPlayer [
	^ board lapAccordingToBoard: (playersOfTheGame positionRecordsOf: aPlayer) lastPosition
]

{ #category : #positions }
Game >> lastPositionOf: aPlayer [ 
	^ board positionAccordingToBoard: (playersOfTheGame positionRecordsOf: aPlayer ) lastPosition.
]

{ #category : #actions }
Game >> move: aPlayer anAmountOfBoxes: aNumber [
	(playersOfTheGame positionRecordsOf: aPlayer) addNewRecord: aNumber + (self applyCardTo: aPlayer) .
]

{ #category : #actions }
Game >> newTurnWithDice: aSetOfDices [ 
	| thePlayer rollValue |
	self assertGameIsOver.
	thePlayer := self currentPlayer.
	rollValue := self roll: aSetOfDices .
	[self assertIsInJail: thePlayer] on: Error do: [self has: aSetOfDices gaveMaxValue: rollValue].
	self move: thePlayer anAmountOfBoxes: rollValue.
	board doEffectOn: thePlayer in: self.
	turnManager updateTurn.
]

{ #category : #'ways to use cards' }
Game >> pickTwoRandomCards [
	^ OrderedCollection with: deckOfCards pickACard with: deckOfCards pickACard .
]

{ #category : #positions }
Game >> positionOf: aPlayer [
	| position |
	position := (playersOfTheGame positionRecordsOf: aPlayer) position.
	^ board positionAccordingToBoard: position.
	
]

{ #category : #'ranking of the game' }
Game >> ranking [
	^ playersOfTheGame ranking
]

{ #category : #'ranking of the game' }
Game >> rankingPositionOf: aPlayer [
	^ playersOfTheGame rankingPositionOf: aPlayer
]

{ #category : #removing }
Game >> removePermanentCard: aCard [
	permanentCards remove: aCard.
]

{ #category : #description }
Game >> restOfPlayers [
	^ (playersOfTheGame allPlayers )
		select: [ :player | player ~= (self currentPlayer) ]
]

{ #category : #actions }
Game >> roll: aSetOfDices [
	^ (aSetOfDices collect: [ :aDice | aDice roll]) sum.
	
]

{ #category : #positions }
Game >> sendAllPlayersToInitialPosition [
	playersOfTheGame sendAllPlayersToInitialPosition
]

{ #category : #'jail actions' }
Game >> sendToJail: aPlayer [
	playersOfTheGame sendToJail: aPlayer
]

{ #category : #'jail actions' }
Game >> setFreeFromJail: aPlayer [
	playersOfTheGame setFreeFromJail: aPlayer.
]

{ #category : #description }
Game >> steps [
	^ board amountOfBoxes
]

{ #category : #'ways to use cards' }
Game >> thePlayer: aPlayer wantsToUseTheCard: aCard on: cardOrPlayer [
	self assertIsTheTurnOf: aPlayer.
	playersOfTheGame remove: aCard to: aPlayer.
	aCard applyEffectOn: cardOrPlayer in: self.
]

{ #category : #'ways to use cards' }
Game >> thePlayer: aPlayer willHaveTheCards: cards [ 
	(playersOfTheGame cardsOf: aPlayer) willHaveTheCards: cards.
]

{ #category : #'ranking of the game' }
Game >> winner [
	^ self ranking at: 1.
]
