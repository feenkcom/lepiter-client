Class {
	#name : #LeClientPost,
	#superclass : #Object,
	#instVars : [
		'page',
		'title',
		'thumbnail',
		'abstract',
		'publishedAt',
		'publishedFile',
		'uuid',
		'publishedUser',
		'database',
		'serverDatabase',
		'client'
	],
	#category : #'LepiterClient-Model'
}

{ #category : #accessing }
LeClientPost class >> forPage: aPage [
	^ self new
		page: aPage uid;
		title: aPage title;
		abstract: (aPage children
				detect: #isTextSnippet
				ifFound: [ :aSnippet | 
					| visitor |
					visitor := LeHtmlTextSnippetPostAbstractVisitor new
							context: LeHtmlContext new;
							snippet: aSnippet.

					visitor contentsFor: aSnippet ]
				ifNone: [ '' ]) asString;
		thumbnail: (aPage children
				detect: [ :aSnippet | aSnippet isKindOf: LePictureSnippet ]
				ifFound: #urlString
				ifNone: [ '' ]) asString
]

{ #category : #accessing }
LeClientPost class >> leJsonV4AttributeMapping [
	^ {#title -> #title.
		#abstract -> #abstract.
		#page -> #page.
		#thumbnail -> #thumbnail.
		#uuid -> #uuid.
		#publishedAt -> #publishedAt.
		#publishedFile -> #publishedFile.
		#publishedUser -> #publishedUser}
]

{ #category : #accessing }
LeClientPost class >> leJsonV4Name [

	^ #apServerPost
]

{ #category : #accessing }
LeClientPost >> abstract [
	^ abstract
]

{ #category : #accessing }
LeClientPost >> abstract: anObject [
	abstract := anObject
]

{ #category : #accessing }
LeClientPost >> client [
	^ client
]

{ #category : #accessing }
LeClientPost >> client: anObject [
	client := anObject
]

{ #category : #accessing }
LeClientPost >> database [
	^ database
]

{ #category : #accessing }
LeClientPost >> database: anObject [
	self
		assert: anObject isString
		description: [ 'Post database must be a string: {1}' format: {anObject} ].
	database := anObject
]

{ #category : #accessing }
LeClientPost >> gtViewCardFor: aView [
	<gtView>

	^ aView explicit
		title: 'Summary';
		priority: 1;
		stencil: [ LeClientPostCardElement new post: self ]
]

{ #category : #accessing }
LeClientPost >> gtViewPageFor: aView [
	<gtView>
	self database ifNil: [ ^ aView empty ].

	^ ((self database pageByUuid: self page) gtLiveFor: aView) title: 'Page'
]

{ #category : #accessing }
LeClientPost >> isPublished [
	^ publishedAt isNotNil
]

{ #category : #accessing }
LeClientPost >> page [
	^ page
]

{ #category : #accessing }
LeClientPost >> page: anObject [
	page := anObject
]

{ #category : #accessing }
LeClientPost >> printOn: aStream [

	aStream 
		nextPutAll: 'Server Post: ';
		print: title
]

{ #category : #accessing }
LeClientPost >> publishTo: aDirectory usingPath: aPath [
	| sequencer pageLinks aPageLink aContext anExporter anHtml resource aPage |
	aPage := self database
			pageWithID: self page
			ifAbsent: [ ^ self error: 'Page not found' ].

	sequencer := LeExportUUIDSequencer new.
	pageLinks := LeExportPageLinksBuilder new
			database: self database;
			html;
			sequencer: sequencer;
			build;
			links.
	aPageLink := pageLinks
			linkForPage: aPage
			ifFound: #yourself
			ifNone: [ self error: 'This should not happen' ].
	aContext := LeClientHtmlContext new
			page: aPage;
			pageLinks: pageLinks;
			pagePath: aPath;
			sequencer: sequencer;
			database: self database;
			serverDatabase: self serverDatabase.

	anExporter := LeHtmlPageExporter new
			context: aContext;
			piece: LeHtmlGtAtpPostPiece atpPost.

	anHtml := anExporter contents.

	aContext resources
		addResource: (resource := LeExportPageOutputResource new
					content: anHtml;
					pageLink: aPageLink).

	LeHtmlAssetsInDirectoryResourceBuilder new
		rootDiretory: FileLocator gtResource / 'feenkcom' / 'lepiter' / 'doc' / 'gtbook' / 'assets';
		resources: aContext resources;
		build.
		
	aContext assembler assemble.

	LeExportResourcesDirectorySaver new
		resources: aContext resources;
		rootDirectory: aDirectory;
		save.

	^ resource path
]

{ #category : #accessing }
LeClientPost >> publishedAt [
	^ publishedAt
]

{ #category : #accessing }
LeClientPost >> publishedAt: anObject [
	publishedAt := anObject
]

{ #category : #accessing }
LeClientPost >> publishedFile [
	^ publishedFile
]

{ #category : #accessing }
LeClientPost >> publishedFile: anObject [
	publishedFile := anObject
]

{ #category : #accessing }
LeClientPost >> publishedUser [
	^ publishedUser
]

{ #category : #accessing }
LeClientPost >> publishedUser: anObject [
	publishedUser := anObject
]

{ #category : #accessing }
LeClientPost >> serverDatabase [
	^ serverDatabase
]

{ #category : #accessing }
LeClientPost >> serverDatabase: anObject [
	serverDatabase := anObject
]

{ #category : #accessing }
LeClientPost >> thumbnail [
	^ thumbnail
]

{ #category : #accessing }
LeClientPost >> thumbnail: anObject [
	thumbnail := anObject
]

{ #category : #accessing }
LeClientPost >> title [
	^ title
]

{ #category : #accessing }
LeClientPost >> title: anObject [
	title := anObject
]

{ #category : #accessing }
LeClientPost >> uuid [
	^ uuid
]

{ #category : #accessing }
LeClientPost >> uuid: anObject [
	uuid := anObject
]
