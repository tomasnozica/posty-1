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
	#name : #DeterministicBuilder,
	#superclass : #BoardBuilder,
	#instVars : [
		'size',
		'draft'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #adding }
DeterministicBuilder >> addAtomicBomb [
	draft := AtomicBombEffect new.
]

{ #category : #adding }
DeterministicBuilder >> addCard [
	draft := CardEffect new.
]

{ #category : #adding }
DeterministicBuilder >> addEmptyEffect [
	draft := EmptyEffect new. 
]

{ #category : #adding }
DeterministicBuilder >> addMoonWalk [
	draft := MoonwalkEffect numberOfStepsBack: 2.
]

{ #category : #adding }
DeterministicBuilder >> addSpeedUp [
	draft := SpeedUpEffect new.
]

{ #category : #adding }
DeterministicBuilder >> addWormHole [
	draft := WormHoleEffect new.
]

{ #category : #building }
DeterministicBuilder >> build [
	^ DeterministicBoard fromDraft: draft andSize: size.
]

{ #category : #building }
DeterministicBuilder >> initiatializeWithSize: aSize [
	size:= aSize
]
