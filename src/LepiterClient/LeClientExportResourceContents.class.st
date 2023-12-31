Class {
	#name : #LeClientExportResourceContents,
	#superclass : #Object,
	#traits : 'TLeClientContentsProvider',
	#classTraits : 'TLeClientContentsProvider classTrait',
	#instVars : [
		'resource'
	],
	#category : #'LepiterClient-Publishing New'
}

{ #category : #accessing }
LeClientExportResourceContents >> basename [
	<return: #String>
	^ self resource path basename
]

{ #category : #accessing }
LeClientExportResourceContents >> bytes [
	<return: #ByteArray>
	^ self resource state isReady
		ifTrue: [ self resource reference binaryContents ]
		ifFalse: [ nil ]
]

{ #category : #accessing }
LeClientExportResourceContents >> name [
	<return: #String>
	^ self resource pathName
]

{ #category : #accessing }
LeClientExportResourceContents >> resource [
	<return: #TLeExportResource>
	^ resource
]

{ #category : #accessing }
LeClientExportResourceContents >> resource: aTLeExportResource [
	resource := aTLeExportResource
]
