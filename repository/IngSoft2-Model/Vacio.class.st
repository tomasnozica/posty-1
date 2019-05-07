"
Please comment me using the following template inspired by Class Responsibility Collaborator (CRC) design:
"" Special box ""
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
	#name : #Vacio,
	#superclass : #Boxes,
	#category : #'IngSoft2-Model'
}

{ #category : #operations }
Vacio class >> create [
	^ self new
		initializeWithProbability;
		yourself
]

{ #category : #action }
Vacio >> effect: toTheGame [
	| thePlayer |
	thePlayer := (toTheGame players) detect: [ :player | (player turn) = (toTheGame actualTurn)].
	thePlayer move: 0.
]

{ #category : #initialize }
Vacio >> initializeWithProbability [ 
	probability := 0.55
]