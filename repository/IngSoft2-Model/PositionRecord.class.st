"
Please comment me using the following template inspired by Class Responsibility Collaborator (CRC) design:

For the Class part:  State a one line summary. For example, ""I represent a paragraph of text"".
""a position handler""
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
	#name : #PositionRecord,
	#superclass : #Object,
	#instVars : [
		'recordOfPositions',
		'player'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
PositionRecord class >> ofPlayer: aPlayer [
	^ self new 
		initializeForPlayer: aPlayer;
		yourself
]

{ #category : #adding }
PositionRecord >> addNewRecord: aNumber [
	recordOfPositions add: aNumber.
]

{ #category : #initialization }
PositionRecord >> initializeForPlayer: aPlayer [
	player := aPlayer .
	recordOfPositions := OrderedCollection new.
	recordOfPositions add:0.
]

{ #category : #accessing }
PositionRecord >> lastPosition [
	^ recordOfPositions sum - recordOfPositions last.
]

{ #category : #accessing }
PositionRecord >> moveToBeginning [
	  recordOfPositions add: (self position) negated 
]

{ #category : #accessing }
PositionRecord >> player [ 
	^ player	
]

{ #category : #accessing }
PositionRecord >> position [
	^ recordOfPositions sum
]
