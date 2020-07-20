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
	size:		<Object>


    Implementation Points
"
Class {
	#name : #AtomicBombBoard,
	#superclass : #BoardBuilder,
	#instVars : [
		'draft',
		'size'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
AtomicBombBoard class >> ofSize: aSize [
	^ self new
		initiatializeWithSize: aSize;
		yourself
]

{ #category : #adding }
AtomicBombBoard >> addAtomicBomb [
	1 to: 100 do: [ :index | draft add: (AtomicBombEffect new) ]
]

{ #category : #adding }
AtomicBombBoard >> addEmptyEffect [
	^0
]

{ #category : #adding }
AtomicBombBoard >> addMoonWalk [
	^0
]

{ #category : #adding }
AtomicBombBoard >> addSpeedUp [
	^0
]

{ #category : #adding }
AtomicBombBoard >> addWormHole [
	^0
]

{ #category : #building }
AtomicBombBoard >> build [
	^Board fromDraft: draft andSize: size
]

{ #category : #building }
AtomicBombBoard >> initiatializeWithSize: aSize [
	draft := OrderedCollection new.
	size:= aSize
]
