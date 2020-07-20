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
	^ #(#(#(#RGPackage #(#'IngSoft2-Model')) #'2020-07-20T18:15:08.640965-03:00') )
]

{ #category : #'code-critics' }
ManifestIngSoftModel class >> ruleRBUnoptimizedToDoRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#Board #initializeFromDraft:andSize: #false)) #'2020-07-20T18:10:17.464325-03:00') )
]
