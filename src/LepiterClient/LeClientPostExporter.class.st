Class {
	#name : #LeClientPostExporter,
	#superclass : #LeClientCompositeCommand,
	#instVars : [
		'htmlContext',
		'htmlSequencer',
		'pageLinks',
		'page',
		'serverDatabase',
		'htmlExporter',
		'pagePath'
	],
	#category : #'LepiterClient-Publishing New'
}

{ #category : #private }
LeClientPostExporter >> createPageOutput [
	<return: #LeExportPageOutputResource>
	| anHtmlContents aPageLink anOutput |
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
LeClientPostExporter >> description [
	^ 'Export page: ' , (self page ifNotNil: #title ifNil: [ '<undefined>' ])
]

{ #category : #'api - actions' }
LeClientPostExporter >> execute [
	<return: #TLeClientResponse>
	| aResponse |
	self
		ifSuccess: [ :aPreviousResponse | ^ aPreviousResponse ]
		ifFailure: [  "repeat" ]
		ifNone: [  "execute" ].
		
	aResponse := self exportPage.
	self addResponse: aResponse.
	^ aResponse
]

{ #category : #private }
LeClientPostExporter >> exportPage [
	<return: #TLeClientResponse>
	| aPageResource aPageOutputResponse |
	[ aPageResource := self createPageOutput.
	aPageOutputResponse := LeClientPageOutputResponse new resource: aPageResource ]
		on: Error
		do: [ :anError | aPageOutputResponse := LeClientExceptionResponse new freeze: anError ].

	^ aPageOutputResponse
]

{ #category : #'gt - extensions' }
LeClientPostExporter >> gtDetails [
	^ super gtDetails , {
		{ 'page' . page }.
		{ 'server database' . serverDatabase }.
		{ 'page links' . pageLinks }.
		{ 'page path' . pagePath }.
		{ 'html sequencer' . htmlSequencer }.
		{ 'html context' . htmlContext }.
		{ 'html exporter' . htmlExporter }
	}
]

{ #category : #private }
LeClientPostExporter >> onServerDatabaseChanged [
	htmlContext ifNotNil: [ :aContext | aContext serverDatabase: serverDatabase ]
]

{ #category : #accessing }
LeClientPostExporter >> page [
	<return: #LePage>
	^ page
]

{ #category : #accessing }
LeClientPostExporter >> page: aLePage [
	page := aLePage
]

{ #category : #'api - actions' }
LeClientPostExporter >> prepare [
	self prepareHtmlSequencer.
	self prepareHtmlPageLinks.
	self prepareHtmlContext.
	self prepareHtmlExporter.
	self prepareHtmlResources.
]

{ #category : #private }
LeClientPostExporter >> prepareHtmlContext [
	htmlContext ifNotNil: [ ^ self ].
	htmlContext := LeClientHtmlContext new
			date: context postPublishDate;
			authorName: context postAuthorName;
			page: page;
			pageLinks: pageLinks;
			sequencer: htmlSequencer;
			database: page database;
			pagePath: pagePath;
			serverDatabase: serverDatabase
]

{ #category : #private }
LeClientPostExporter >> prepareHtmlExporter [
	htmlExporter ifNotNil: [ ^ self ].
	htmlExporter := LeHtmlPageExporter new
			context: htmlContext;
			piece: LeHtmlGtAtpPostPiece atpPost
]

{ #category : #private }
LeClientPostExporter >> prepareHtmlPageLinks [
	pageLinks ifNotNil: [ ^ self ].
	pageLinks := LeExportPageLinksBuilder new
			database: page database;
			html;
			sequencer: htmlSequencer;
			build;
			links
]

{ #category : #private }
LeClientPostExporter >> prepareHtmlResources [
	htmlExporter buildResources
]

{ #category : #private }
LeClientPostExporter >> prepareHtmlSequencer [
	htmlSequencer ifNotNil: [ ^ self ].
	htmlSequencer := LeExportUUIDSequencer new
]

{ #category : #accessing }
LeClientPostExporter >> resources [
	<return: #LeExportResources>
	^ htmlContext resources
]

{ #category : #accessing }
LeClientPostExporter >> serverDatabase [
	<return: #LeClientOrganization>
	^ serverDatabase
]

{ #category : #accessing }
LeClientPostExporter >> serverDatabase: aLeClientDatabase [
	serverDatabase := aLeClientDatabase.
	self onServerDatabaseChanged.
]
