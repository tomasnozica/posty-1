"
I store metadata for this package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestIngSoftModel,
	#superclass : #PackageManifest,
	#category : #'IngSoft2-Model-Manifest'
}

{ #category : #'code-critics' }
ManifestIngSoftModel class >> ruleRBCollectSelectNotUsedRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#RandomBoard #initializeFromDraft:andSize: #false)) #'2020-08-03T16:14:13.287956-03:00') #(#(#RGMethodDefinition #(#DeterministicBoard #initializeFromDraft:andSize: #false)) #'2020-08-03T16:14:23.055179-03:00') )
]
