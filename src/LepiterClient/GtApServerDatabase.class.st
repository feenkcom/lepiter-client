Class {
	#name : #GtApServerDatabase,
	#superclass : #Object,
	#instVars : [
		'server',
		'token',
		'pages',
		'posts',
		'name',
		'description',
		'ledatabase',
		'slug',
		'user',
		'id'
	],
	#category : #'LepiterClient-Model'
}

{ #category : #accessing }
GtApServerDatabase class >> leJsonV4AttributeMapping [
	^ {#name -> #name.
		#id -> #id.
		#slug -> #slug.
		#description -> #description.
		#ledatabase -> #ledatabase}
]

{ #category : #accessing }
GtApServerDatabase class >> leJsonV4Name [
	^ #apServerDatabase
]

{ #category : #accessing }
GtApServerDatabase >> description [
	^ description
]

{ #category : #accessing }
GtApServerDatabase >> description: anObject [
	description := anObject
]

{ #category : #accessing }
GtApServerDatabase >> formatDictionary [
	^ {#name -> self name.
		#id -> self id.
		#slug -> self slug.
		#description -> self description} asDictionary
]

{ #category : #accessing }
GtApServerDatabase >> gtOverviewFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Overview';
		priority: 1;
		items: [ self formatDictionary associations ];
		actionUpdateButtonTooltip: 'Update overview';
		column: 'Name' text: #key;
		column: 'Value'
			text: [ :aPair | aPair value asString ]
			weight: 2;
		send: #value
]

{ #category : #accessing }
GtApServerDatabase >> gtPagesFor: aView [
	<gtView>
	self server ifNil: [ ^ aView empty ].

	^ aView columnedList
		title: 'Pages';
		priority: 1;
		items: [ self pages ];
		column: 'Content'
			text: [ :aPageOrDailyNote | 
				(aPageOrDailyNote isKindOf: LeDailyNote)
					ifTrue: [ aPageOrDailyNote date ]
					ifFalse: [ aPageOrDailyNote contentAsString ] ];
		column: 'Time'
			text: [ :aPageOrDailyNote | 
				(aPageOrDailyNote isKindOf: LeDailyNote)
					ifTrue: [ '' ]
					ifFalse: [ aPageOrDailyNote editTime ] ];
		column: 'Author'
			text: [ :aPageOrDailyNote | 
				(aPageOrDailyNote isKindOf: LeDailyNote)
					ifTrue: [ '' ]
					ifFalse: [ aPageOrDailyNote editEmail ] ];
		actionButtonIcon: BrGlamorousVectorIcons refresh
			tooltip: 'Update'
			action: [ :aButton :aTab | 
				self refreshPages.
				aTab viewContentElement phlow update ]
]

{ #category : #accessing }
GtApServerDatabase >> gtPostsFor: aView [
	<gtView>
	self server ifNil: [ ^ aView empty ].

	^ aView columnedList
		title: 'Posts';
		priority: 1;
		items: [ self posts ];
		column: 'Title' text: #title;
		column: 'Abstract' text: #abstract;
		column: 'Published'
			text: #isPublished
			width: 75;
		actionButtonIcon: BrGlamorousVectorIcons refresh
			tooltip: 'Update'
			action: [ :aButton :aTab | 
				self refreshPosts.
				aTab viewContentElement phlow update ]
]

{ #category : #accessing }
GtApServerDatabase >> id [
	^ id
]

{ #category : #accessing }
GtApServerDatabase >> id: anObject [
	id := anObject
]

{ #category : #accessing }
GtApServerDatabase >> ledatabase [
	^ ledatabase
]

{ #category : #accessing }
GtApServerDatabase >> ledatabase: anObject [
	ledatabase := anObject
]

{ #category : #accessing }
GtApServerDatabase >> lepiterDatabase [
	^ self ledatabase
]

{ #category : #accessing }
GtApServerDatabase >> location [
	^ self server , '/' , self slug
]

{ #category : #accessing }
GtApServerDatabase >> name [
	^ name
]

{ #category : #accessing }
GtApServerDatabase >> name: anObject [
	name := anObject
]

{ #category : #accessing }
GtApServerDatabase >> pageByUuid: aUuid [
	^ self pages detect: [ :aPage | aPage uid = aUuid ]
]

{ #category : #accessing }
GtApServerDatabase >> pages [
	^ pages ifNil: [ self refreshPages ]
]

{ #category : #accessing }
GtApServerDatabase >> posts [
	^ posts ifNil: [ self refreshPosts ]
]

{ #category : #accessing }
GtApServerDatabase >> refreshPages [
	^ pages := (ZnClient new beOneShot
			url: self server , '/api/pages?database=' , self ledatabase asString;
			setBearerAuthentication: self token;
			get;
			response) entity string
			readStreamDo: [ :aStream | LeJsonV4 uniqueInstance deserialize: aStream ]
]

{ #category : #accessing }
GtApServerDatabase >> refreshPosts [
	^ posts := (((ZnClient new beOneShot
			url: self server , '/api/posts?database=' , self ledatabase asString;
			get;
			response) entity string
			readStreamDo: [ :aStream | LeJsonV4 uniqueInstance deserialize: aStream ])
			at: 'posts') collect: [ :aPost | aPost database: self ]
]

{ #category : #accessing }
GtApServerDatabase >> server [
	^ server
]

{ #category : #accessing }
GtApServerDatabase >> server: anObject [
	server := anObject
]

{ #category : #accessing }
GtApServerDatabase >> slug [
	^ slug
]

{ #category : #accessing }
GtApServerDatabase >> slug: anObject [
	slug := anObject
]

{ #category : #accessing }
GtApServerDatabase >> token [
	^ token
]

{ #category : #accessing }
GtApServerDatabase >> token: anObject [
	token := anObject
]

{ #category : #accessing }
GtApServerDatabase >> user [
	^ user
]

{ #category : #accessing }
GtApServerDatabase >> user: anObject [
	user := anObject
]
