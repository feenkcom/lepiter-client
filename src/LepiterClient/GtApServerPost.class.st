Class {
	#name : #GtApServerPost,
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
		'serverDatabase'
	],
	#category : #'LepiterClient-Model'
}

{ #category : #accessing }
GtApServerPost class >> forPage: aPage [
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
GtApServerPost class >> leJsonV4AttributeMapping [
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
GtApServerPost class >> leJsonV4Name [

	^ #apServerPost
]

{ #category : #accessing }
GtApServerPost >> abstract [
	^ abstract
]

{ #category : #accessing }
GtApServerPost >> abstract: anObject [
	abstract := anObject
]

{ #category : #accessing }
GtApServerPost >> database [
	^ database
]

{ #category : #accessing }
GtApServerPost >> database: anObject [
	database := anObject
]

{ #category : #accessing }
GtApServerPost >> gtViewCardFor: aView [
	<gtView>

	^ aView explicit
		title: 'Summary';
		priority: 1;
		stencil: [ GtApServerPostCardElement new post: self ]
]

{ #category : #accessing }
GtApServerPost >> gtViewPageFor: aView [
	<gtView>
	self database ifNil: [ ^ aView empty ].

	^ ((self database pageByUuid: self page) gtLiveFor: aView) title: 'Page'
]

{ #category : #accessing }
GtApServerPost >> isPublished [
	^ publishedAt isNotNil
]

{ #category : #accessing }
GtApServerPost >> page [
	^ page
]

{ #category : #accessing }
GtApServerPost >> page: anObject [
	page := anObject
]

{ #category : #accessing }
GtApServerPost >> printOn: aStream [

	aStream 
		nextPutAll: 'Server Post: ';
		print: title
]

{ #category : #accessing }
GtApServerPost >> publishTo: aDirectory usingPath: aPath [
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
	aContext := GtApHtmlContext new
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
GtApServerPost >> publishedAt [
	^ publishedAt
]

{ #category : #accessing }
GtApServerPost >> publishedAt: anObject [
	publishedAt := anObject
]

{ #category : #accessing }
GtApServerPost >> publishedFile [
	^ publishedFile
]

{ #category : #accessing }
GtApServerPost >> publishedFile: anObject [
	publishedFile := anObject
]

{ #category : #accessing }
GtApServerPost >> publishedUser [
	^ publishedUser
]

{ #category : #accessing }
GtApServerPost >> publishedUser: anObject [
	publishedUser := anObject
]

{ #category : #accessing }
GtApServerPost >> serverDatabase [
	^ serverDatabase
]

{ #category : #accessing }
GtApServerPost >> serverDatabase: anObject [
	serverDatabase := anObject
]

{ #category : #accessing }
GtApServerPost >> thumbnail [
	^ thumbnail
]

{ #category : #accessing }
GtApServerPost >> thumbnail: anObject [
	thumbnail := anObject
]

{ #category : #accessing }
GtApServerPost >> title [
	^ title
]

{ #category : #accessing }
GtApServerPost >> title: anObject [
	title := anObject
]

{ #category : #accessing }
GtApServerPost >> uuid [
	^ uuid
]

{ #category : #accessing }
GtApServerPost >> uuid: anObject [
	uuid := anObject
]
