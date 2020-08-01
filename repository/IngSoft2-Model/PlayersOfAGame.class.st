"
Please comment me using the following template inspired by Class Responsibility Collaborator (CRC) design:
""nothing yet""
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
	listOfXYZ:		<Object>


    Implementation Points
"
Class {
	#name : #PlayersOfAGame,
	#superclass : #Object,
	#instVars : [
		'positionRecord',
		'cardsOfPlayer',
		'listOfPermanentCardsOfPlayer',
		'game'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
PlayersOfAGame class >> listOfPositionOfPlayers: aListOfPositionOfPlayers listOfCardsOfPlayers: aListOfCardsOfPlayer listOfPermanentCardsOfPlayers: aListOfPermanentCardsOfPlayer [
	^ self new
		initializeWithPositionRecords: aListOfPositionOfPlayers
		cards: aListOfCardsOfPlayer
		permanentCards: aListOfPermanentCardsOfPlayer; yourself
]

{ #category : #cardActions }
PlayersOfAGame >> addCard: aCard toPlayer: aPlayer [ 
	(self cardsOf: aPlayer) addCard: aCard.
]

{ #category : #playerActions }
PlayersOfAGame >> allPlayers [
	^ positionRecord collect: [ :eachPositionOfPlayer | eachPositionOfPlayer player ]
]

{ #category : #description }
PlayersOfAGame >> amountOfCardsOf: aPlayer [
	^ (self cardsOf: aPlayer) amountOfCards.
]

{ #category : #cardActions }
PlayersOfAGame >> applyCardTo: aPlayer [ 
	^ (self cardsOf: aPlayer) applyEffects.
]

{ #category : #cardActions }
PlayersOfAGame >> cardsOf: aPlayer [
	^ cardsOfPlayer detect: [ :cardsOf | cardsOf player = aPlayer  ].
]

{ #category : #playerActions }
PlayersOfAGame >> hasAnyPlayerReachedPosition: aPosition [ 
	^ positionRecord anySatisfy: [ :eachPositionRecord | eachPositionRecord position > aPosition ]
]

{ #category : #initialization }
PlayersOfAGame >> initializeWithPositionRecords: aListOfPositionOfPlayers cards: aListOfCardsOfPlayer permanentCards: aListOfPermanentCardsOfPlayers [
	positionRecord := aListOfPositionOfPlayers.
	cardsOfPlayer := aListOfCardsOfPlayer.
	listOfPermanentCardsOfPlayer := aListOfPermanentCardsOfPlayers.
]

{ #category : #cardActions }
PlayersOfAGame >> permanentCardsOf: aPlayer [ 
	| permanentCardsOfPlayer |
	permanentCardsOfPlayer := listOfPermanentCardsOfPlayer detect: [ :permanentCardsOf | permanentCardsOf player = aPlayer ].
	^ permanentCardsOfPlayer allCards.
]

{ #category : #positionActions }
PlayersOfAGame >> positionRecordsOf: aPlayer [ 
	^ positionRecord detect: [ :eachPositionRecord | eachPositionRecord player = aPlayer ].
]

{ #category : #'ranking of the game' }
PlayersOfAGame >> ranking [
	(positionRecord) sort: [ :element1 :element2 | element1 position  > element2 position].
	^ positionRecord collect: [ :element | element player ]
]

{ #category : #'ranking of the game' }
PlayersOfAGame >> rankingPositionOf: aPlayer [
	(self ranking) doWithIndex: [ :element :index | element = aPlayer 
		ifTrue: [ ^ index ]].
]

{ #category : #removing }
PlayersOfAGame >> remove: aCard to: aPlayer [
	(cardsOfPlayer detect: [ :cards | cards player = aPlayer ]) discard: aCard
	
]

{ #category : #playerActions }
PlayersOfAGame >> sendAllPlayersToInitialPosition [ 
	positionRecord  do: [ :eachPlayer | eachPlayer moveToBeginning ].
]
