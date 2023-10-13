Class {
	#name : #LeClientRenderedPostPublisher,
	#superclass : #LeClientCommand,
	#instVars : [
		'page',
		'serverDatabase',
		'post',
		'resourcesCommand',
		'createRenderedPost',
		'postExporter'
	],
	#category : #'LepiterClient-Publishing New'
}

{ #category : #private }
LeClientRenderedPostPublisher >> allFiguresFromResponse: aResourcesResponse [
	| allModels allFigures |
	allModels := aResourcesResponse subresponses collect: #model.
	allFigures := Dictionary new.
	allModels do: [ :aLeClientCreateFile | 
		allFigures 
			at: aLeClientCreateFile contentsProvider basename 
			put: aLeClientCreateFile blob ].
	^ allFigures
]

{ #category : #accessing }
LeClientRenderedPostPublisher >> commands [
	^ LeClientUtility
		collectionWithoutNilItemsFrom: {postExporter.
				resourcesCommand.
				createRenderedPost}
]

{ #category : #accessing }
LeClientRenderedPostPublisher >> description [
	^ 'Export and publish rendered post: ' , self post title
]

{ #category : #'api - actions' }
LeClientRenderedPostPublisher >> execute [
	<return: #TLeClientResponse>
	| aResourcesResponse anExportResponse aCreateRenderedPostResponse aResponse |
	self
		ifSuccess: [ :aPreviousResponse | ^ aPreviousResponse ]
		ifFailure: [  "repeat" ]
		ifNone: [  "execute" ].

	anExportResponse := postExporter execute.
	aResourcesResponse := anExportResponse
			ifSuccess: [ resourcesCommand execute ]
			ifFailure: [ LeClientCannotExecute new ]
			ifNone: [ LeClientCannotExecute new ].
	aCreateRenderedPostResponse := aResourcesResponse
			ifSuccess: [ createRenderedPost
					contents: anExportResponse contents;
					filePath: anExportResponse filePath;
					figures: (self allFiguresFromResponse: aResourcesResponse);
					execute ]
			ifFailure: [ LeClientCannotExecute new ]
			ifNone: [ LeClientCannotExecute new ].

	aResponse := LeClientRenderedPostResponse new
		exportResponse: anExportResponse;
		resourcesResponse: aResourcesResponse;
		createRenderedPostResponse: aCreateRenderedPostResponse.
	self addResponse: aResponse.
	^ aResponse
]

{ #category : #'api - responses' }
LeClientRenderedPostPublisher >> filePath [
	<return: #RelativePath>
	^ self
		ifSuccess: [ createRenderedPost filePath asFileReference asPath ]
		ifFailure: [ nil ]
		ifNone: [ nil ]
]

{ #category : #private }
LeClientRenderedPostPublisher >> onPostChanged [
	createRenderedPost ifNotNil: [ :aCommand | aCommand post: post ]
]

{ #category : #private }
LeClientRenderedPostPublisher >> onServerDatabaseChanged [
	postExporter ifNotNil: [ :aCommand | aCommand serverDatabase: serverDatabase ]
]

{ #category : #accessing }
LeClientRenderedPostPublisher >> page [
	<return: #LePage>
	^ page
]

{ #category : #accessing }
LeClientRenderedPostPublisher >> page: aLePage [
	self
		assert: [ aLePage isKindOf: LePage ]
		description: [ 'Page must be a LePage instance: {1}' format: {aLePage} ].

	page := aLePage
]

{ #category : #accessing }
LeClientRenderedPostPublisher >> post [
	<return: #LeClientPost>
	^ post
]

{ #category : #accessing }
LeClientRenderedPostPublisher >> post: aPost [
	post := aPost.
	self onPostChanged
]

{ #category : #'api - convenience' }
LeClientRenderedPostPublisher >> postFromPage: aPage [
	self page: aPage.
	self post: (LeClientPost forPage: aPage)
]

{ #category : #'api - actions' }
LeClientRenderedPostPublisher >> prepare [
	self preparePostExporter.
	self prepareHtmlResources.
	self prepareCreateRenderedPost
]

{ #category : #private }
LeClientRenderedPostPublisher >> prepareCreateRenderedPost [
	createRenderedPost := LeClientApiCreateRenderedPost new
			context: context;
			post: post.
	createRenderedPost prepare
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
	| commandsAndNils onlyCommands |
	resourcesCommand ifNotNil: [ ^ self ].
	commandsAndNils := postExporter resources
			collect: [ :aResource | self prepareHtmlResource: aResource ].
	onlyCommands := commandsAndNils reject: #isNil.

	resourcesCommand := onlyCommands
			ifNotEmpty: [ LeClientMultiCommand new
					name: 'Publish resources';
					commands: onlyCommands ]
			ifEmpty: [ LeClientNoActionCommand ready: 'No resources to publish' ].
	resourcesCommand prepare
]

{ #category : #private }
LeClientRenderedPostPublisher >> preparePostExporter [
	postExporter ifNotNil: [ ^ self ].
	postExporter := LeClientPostExporter new
			context: context;
			page: page;
			serverDatabase: serverDatabase.
	postExporter prepare
]

{ #category : #accessing }
LeClientRenderedPostPublisher >> serverDatabase [
	<return: #LeClientOrganization>
	^ serverDatabase
]

{ #category : #accessing }
LeClientRenderedPostPublisher >> serverDatabase: aLeClientDatabase [
	serverDatabase := aLeClientDatabase.
	self onServerDatabaseChanged
]

{ #category : #'api - responses' }
LeClientRenderedPostPublisher >> serverPost [
	<return: #LeClientPost>
	^ self
		ifSuccess: [ :aLastResponse | aLastResponse model post ]
		ifFailure: [ nil ]
		ifNone: [ nil ]
]
