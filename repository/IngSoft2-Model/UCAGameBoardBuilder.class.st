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

    Instance Variables
	draft:		<Object>


    Implementation Points
"
Class {
	#name : #UCAGameBoardBuilder,
	#superclass : #BoardBuilder,
	#instVars : [
		'draft',
		'size'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
UCAGameBoardBuilder class >> ofSize: aSize [
	^ self new
		initiatializeWithSize: aSize;
		yourself
]

{ #category : #adding }
UCAGameBoardBuilder >> addAtomicBomb [
	1 to: 2 do: [ :index | draft add: (AtomicBombEffect new) ]
]

{ #category : #adding }
UCAGameBoardBuilder >> addCard [
	1 to: 10 do: [ :index | draft add: (CardEffect new) ]
]

{ #category : #adding }
UCAGameBoardBuilder >> addEmptyEffect [
	1 to: 45 do: [ :index | draft add: (EmptyEffect  new) ]
]

{ #category : #adding }
UCAGameBoardBuilder >> addMoonWalk [
	| random n |
	random := Random new.
	n := (random next * 5)+1.
	1 to: 10 do: [ :index | draft add: (MoonwalkEffect numberOfStepsBack: n asInteger) ]
]

{ #category : #adding }
UCAGameBoardBuilder >> addSpeedUp [
	1 to: 20 do: [ :index | draft add: (SpeedUpEffect  new) ]
]

{ #category : #adding }
UCAGameBoardBuilder >> addWormHole [
	1 to: 20 do: [ :index | draft add: (WormHoleEffect  new) ]
]

{ #category : #building }
UCAGameBoardBuilder >> build [
	^Board fromDraft: draft andSize: size
]

{ #category : #building }
UCAGameBoardBuilder >> initiatializeWithSize: aSize [
	draft := OrderedCollection new.
	size:= aSize
]
