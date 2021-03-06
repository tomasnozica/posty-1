"
Please comment me using the following template inspired by Class Responsibility Collaborator (CRC) design:
""Abstract object""
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
	#name : #BoardBuilder,
	#superclass : #Object,
	#instVars : [
		'draft',
		'size'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
BoardBuilder class >> ofSize: aSize [
	^ self new
		initiatializeWithSize: aSize;
		yourself
]

{ #category : #adding }
BoardBuilder >> addAtomicBomb [
	self subclassResponsibility 
]

{ #category : #adding }
BoardBuilder >> addCard [
	self subclassResponsibility 
]

{ #category : #adding }
BoardBuilder >> addEmptyEffect [
	self subclassResponsibility 
]

{ #category : #adding }
BoardBuilder >> addJailEffect [
	self subclassResponsibility.
]

{ #category : #adding }
BoardBuilder >> addMoonWalk [
	self subclassResponsibility 
]

{ #category : #adding }
BoardBuilder >> addSpeedUp [
	self subclassResponsibility 
]

{ #category : #adding }
BoardBuilder >> addWormHole [
	self subclassResponsibility 
]

{ #category : #building }
BoardBuilder >> build [
	self subclassResponsibility 
]

{ #category : #accessing }
BoardBuilder >> initiatializeWithSize: arg1 [ 
	^ self subclassResponsibility
]
