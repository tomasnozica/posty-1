"
Please comment me using the following template inspired by Class Responsibility Collaborator (CRC) design:
""Testing board creation acording to probability ""
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
	#name : #BoardTest,
	#superclass : #TestCase,
	#instVars : [
		'board'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #running }
BoardTest >> setUp [
	| boardBuilder |
	super setUp.
	boardBuilder := UCAGameBoardBuilder  ofSize: 5.
	boardBuilder addAtomicBomb .
	boardBuilder addEmptyEffect .
	boardBuilder addMoonWalk .
	boardBuilder addSpeedUp .
	boardBuilder addWormHole .
	board := boardBuilder build.
]

{ #category : #tests }
BoardTest >> testAmountOfBoxes [
	self assert: board amountOfBoxes equals: 5.
	
]
