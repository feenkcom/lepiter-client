Class {
	#name : #LeClientDatabase,
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
LeClientDatabase class >> leJsonV4AttributeMapping [
	^ {#name -> #name.
		#id -> #id.
		#slug -> #slug.
		#description -> #description.
		#ledatabase -> #ledatabase}
]

{ #category : #accessing }
LeClientDatabase class >> leJsonV4Name [
	^ #apServerDatabase
]

{ #category : #accessing }
LeClientDatabase >> description [
	^ description
]

{ #category : #accessing }
LeClientDatabase >> description: anObject [
	description := anObject
]

{ #category : #accessing }
LeClientDatabase >> formatDictionary [
	^ {#name -> self name.
		#id -> self id.
		#slug -> self slug.
		#description -> self description} asDictionary
]

{ #category : #accessing }
LeClientDatabase >> gtOverviewFor: aView [
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
LeClientDatabase >> gtPagesFor: aView [
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
LeClientDatabase >> gtPostsFor: aView [
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
LeClientDatabase >> id [
	^ id
]

{ #category : #accessing }
LeClientDatabase >> id: anObject [
	id := anObject
]

{ #category : #accessing }
LeClientDatabase >> ledatabase [
	^ ledatabase
]

{ #category : #accessing }
LeClientDatabase >> ledatabase: anObject [
	ledatabase := anObject
]

{ #category : #accessing }
LeClientDatabase >> lepiterDatabase [
	^ self ledatabase
]

{ #category : #accessing }
LeClientDatabase >> location [
	^ self server asZnUrl / self slug
]

{ #category : #accessing }
LeClientDatabase >> name [
	^ name
]

{ #category : #accessing }
LeClientDatabase >> name: anObject [
	name := anObject
]

{ #category : #accessing }
LeClientDatabase >> pageByUuid: aUuid [
	^ self pages detect: [ :aPage | aPage uid = aUuid ]
]

{ #category : #accessing }
LeClientDatabase >> pages [
	^ pages ifNil: [ self refreshPages ]
]

{ #category : #accessing }
LeClientDatabase >> posts [
	^ posts ifNil: [ self refreshPosts ]
]

{ #category : #accessing }
LeClientDatabase >> refreshPages [
	^ pages := (ZnClient new beOneShot
			url: self server asZnUrl / '/api/pages' ? ('database' -> self ledatabase asString);
			setBearerAuthentication: self token;
			get;
			response) entity string
			readStreamDo: [ :aStream | LeJsonV4 uniqueInstance deserialize: aStream ]
]

{ #category : #accessing }
LeClientDatabase >> refreshPosts [
	^ posts := (((ZnClient new beOneShot
			url: self server , '/api/posts?database=' , self ledatabase asString;
			get;
			response) entity string
			readStreamDo: [ :aStream | LeJsonV4 uniqueInstance deserialize: aStream ])
			at: 'posts') collect: [ :aPost | aPost database: self ]
]

{ #category : #accessing }
LeClientDatabase >> server [
	^ server
]

{ #category : #accessing }
LeClientDatabase >> server: anObject [
	server := anObject
]

{ #category : #accessing }
LeClientDatabase >> slug [
	^ slug
]

{ #category : #accessing }
LeClientDatabase >> slug: anObject [
	slug := anObject
]

{ #category : #accessing }
LeClientDatabase >> token [
	^ token
]

{ #category : #accessing }
LeClientDatabase >> token: anObject [
	token := anObject
]

{ #category : #accessing }
LeClientDatabase >> user [
	^ user
]

{ #category : #accessing }
LeClientDatabase >> user: anObject [
	user := anObject
]
