Class {
	#name : #LeClientRenderedPostPublisher,
	#superclass : #LeClientCommand,
	#instVars : [
		'page',
		'htmlContext',
		'pageLinks',
		'serverDatabase',
		'htmlSequencer',
		'htmlExporter',
		'post',
		'resourcesCommand',
		'createRenderedPost',
		'pageOutputResponse'
	],
	#category : #'LepiterClient-Publishing New'
}

{ #category : #accessing }
LeClientRenderedPostPublisher >> commands [
	^ LeClientUtility collectionWithoutNilItemsFrom: { resourcesCommand. createRenderedPost }
]

{ #category : #private }
LeClientRenderedPostPublisher >> createPageOutput [
	<return: #LeExportPageOutputResource>
	| anHtmlContents aPageLink anOutput exportDirectory |
	aPageLink := pageLinks
			linkForPage: page
			ifFound: #yourself
			ifNone: [ self
					error: ('Page link must exist: {1}' format: {page ifNotNil: #title}) ].
	anHtmlContents := htmlExporter
			contentsDo: [ :theExporter | theExporter exportHtml ].
	anOutput := LeExportPageOutputResource new
			content: anHtmlContents;
			pageLink: aPageLink.

	htmlContext assembler assemble.

	^ anOutput
]

{ #category : #accessing }
LeClientRenderedPostPublisher >> description [
	^ 'Publish rendered post: ' , self post title
]

{ #category : #'api - actions' }
LeClientRenderedPostPublisher >> execute [
	<return: #TLeClientResponse>
	| aResourcesResponse anExportResponse aCreateRenderedPostResponse aResponse |
	self
		ifSuccess: [ :aPreviousResponse | ^ aPreviousResponse ]
		ifFailure: [  "repeat" ]
		ifNone: [  "execute" ].

	anExportResponse := self exportPage.
	aResourcesResponse := anExportResponse
			ifSuccess: [ resourcesCommand execute ]
			ifFailure: [ LeClientCannotExecute new ]
			ifNone: [ LeClientCannotExecute new ].
	aCreateRenderedPostResponse := aResourcesResponse
			ifSuccess: [ | allModels allFigures |
				allModels := aResourcesResponse subresponses collect: #model.
				allFigures := allModels
						collect: [ :each | each contentsProvider basename -> each blob ].
				createRenderedPost
					contents: anExportResponse contents;
					filePath: anExportResponse filePath;
					figures: allFigures;
					execute ]
			ifFailure: [ LeClientCannotExecute new ]
			ifNone: [ LeClientCannotExecute new ].

	aResponse := LeClientMultiResponse new
			subresponses: {anExportResponse.
					aResourcesResponse.
					aCreateRenderedPostResponse}.
	self addResponse: aResponse.
	^ aResponse
]

{ #category : #private }
LeClientRenderedPostPublisher >> exportPage [
	<return: #TLeClientResponse>
	| aResource |
	pageOutputResponse
		ifSuccess: [ :aPreviousResponse | ^ aPreviousResponse ]
		ifFailure: [  "repeat" ]
		ifNone: [  "execute" ].

	[ aResource := self createPageOutput.
	pageOutputResponse := LeClientPageOutputResponse new resource: aResource ]
		on: Error
		do: [ :anError | pageOutputResponse := LeClientExceptionResponse new freeze: anError ].

	^ pageOutputResponse
]

{ #category : #accessing }
LeClientRenderedPostPublisher >> page [
	<return: #LePage>
	^ page
]

{ #category : #accessing }
LeClientRenderedPostPublisher >> page: aLePage [
	page := aLePage
]

{ #category : #accessing }
LeClientRenderedPostPublisher >> post [
	<return: #LeClientPost>
	^ post
]

{ #category : #accessing }
LeClientRenderedPostPublisher >> post: aPost [
	post := aPost
]

{ #category : #'api - convenience' }
LeClientRenderedPostPublisher >> postFromPage: aPage [
	self page: aPage.
	self post: (LeClientPost forPage: aPage)
]

{ #category : #'api - actions' }
LeClientRenderedPostPublisher >> prepare [
	self prepareHtmlSequencer.
	self prepareHtmlPageLinks.
	self prepareHtmlContext.
	self prepareHtmlExporter.
	self prepareHtmlResources.
	self prepareCreateRenderedPost.
]

{ #category : #private }
LeClientRenderedPostPublisher >> prepareCreateRenderedPost [
	createRenderedPost := LeClientApiCreateRenderedPost new
			context: context;
			post: post.
	createRenderedPost prepare
]

{ #category : #private }
LeClientRenderedPostPublisher >> prepareHtmlContext [
	htmlContext ifNotNil: [ ^ self ].
	htmlContext := LeClientHtmlContext new
			page: page;
			pageLinks: pageLinks;
			sequencer: htmlSequencer;
			database: page database;
			serverDatabase: serverDatabase
]

{ #category : #private }
LeClientRenderedPostPublisher >> prepareHtmlExporter [
	htmlExporter ifNotNil: [ ^ self ].
	pageOutputResponse := LeClientNoResponse new.
	htmlExporter := LeHtmlPageExporter new
			context: htmlContext;
			piece: LeHtmlGtAtpPostPiece atpPost
]

{ #category : #private }
LeClientRenderedPostPublisher >> prepareHtmlPageLinks [
	pageLinks ifNotNil: [ ^ self ].
	pageLinks := LeExportPageLinksBuilder new
			database: page database;
			html;
			sequencer: htmlSequencer;
			build;
			links
]

{ #category : #private }
LeClientRenderedPostPublisher >> prepareHtmlResource: aResource [
	^ aResource isAssetResource
		ifFalse: [ LeClientApiCreateFile new
				context: context;
				resource: aResource ]
		ifTrue: [ nil ]
]

{ #category : #private }
LeClientRenderedPostPublisher >> prepareHtmlResources [
	| resourceCommandsAndNils |
	resourcesCommand ifNotNil: [ ^ self ].
	LeHtmlAssetsUtility addGtBookAssetsInto: htmlContext resources.
	htmlExporter buildResources.
	resourceCommandsAndNils := htmlContext resources
			collect: [ :aResource | self prepareHtmlResource: aResource ].
	resourcesCommand := LeClientMultiCommand new
			name: 'Publish resources';
			commands: (resourceCommandsAndNils reject: #isNil).
	resourcesCommand prepare
]

{ #category : #private }
LeClientRenderedPostPublisher >> prepareHtmlSequencer [
	htmlSequencer ifNotNil: [ ^ self ].
	htmlSequencer := LeExportUUIDSequencer new
]

{ #category : #accessing }
LeClientRenderedPostPublisher >> serverDatabase [
	<return: #LeClientDatabase>
	^ serverDatabase
]

{ #category : #accessing }
LeClientRenderedPostPublisher >> serverDatabase: aLeClientDatabase [
	serverDatabase := aLeClientDatabase
]
