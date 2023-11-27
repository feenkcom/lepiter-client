Class {
	#name : #LeClientApiCreateFile,
	#superclass : #LeClientCommand,
	#instVars : [
		'contentsProvider'
	],
	#category : #'LepiterClient-Publishing New'
}

{ #category : #accessing }
LeClientApiCreateFile >> blob [
	<return: #String or: nil>
	^ self
		ifSuccess: [ :aResponse | aResponse model ifNotNil: #blob ]
		ifFailure: [ :aResponse | nil ]
		ifNone: [ nil ]
]

{ #category : #accessing }
LeClientApiCreateFile >> contentsProvider [
	<return: #TLeClientContentsProvider>
	^ contentsProvider
]

{ #category : #accessing }
LeClientApiCreateFile >> contentsProvider: aTLeClientContentsProvider [
	contentsProvider := aTLeClientContentsProvider
]

{ #category : #accessing }
LeClientApiCreateFile >> description [
	^ 'Create content: '
		, (self contentsProvider ifNotNil: #name ifNil: [ '<undefined>' ])
]

{ #category : #'api - actions' }
LeClientApiCreateFile >> execute [
	<return: #TLeClientResponse>
	| aResponse |
	self
		ifSuccess: [ :aPreviousResponse | ^ aPreviousResponse ]
		ifFailure: [  "repeat" ]
		ifNone: [  "execute" ].

	self
		assert: [ contentsProvider isNotNil ]
		description: [ 'contents provider is not defined' ].

	aResponse := self context zinc
			endpoint: LeClientEndpoints apiCreateFile;
			authenticated;
			bytes: contentsProvider bytes;
			onSuccessJsonModel: [ :aDictionary | 
				LeClientCreateFile new
					jsonObject: aDictionary;
					contentsProvider: contentsProvider ];
			post.

	self addResponse: aResponse.
	^ aResponse
]

{ #category : #'gt - extensions' }
LeClientApiCreateFile >> gtDetails [
	^ super gtDetails , {
		{ 'contents provider' . self contentsProvider ifNil: [ '' ] . self contentsProvider }
	}
]

{ #category : #'api - actions' }
LeClientApiCreateFile >> prepare [
	"do nothing"
]

{ #category : #'api - convenience' }
LeClientApiCreateFile >> resource: aTLeExportResource [
	contentsProvider := LeClientExportResourceContents new
			resource: aTLeExportResource
]

{ #category : #'api - convenience' }
LeClientApiCreateFile >> snippetAttachment: aSnippetAttachment [
	contentsProvider := LeClientSnippetAttachmentContents new
			snippetAttachment: aSnippetAttachment
]
