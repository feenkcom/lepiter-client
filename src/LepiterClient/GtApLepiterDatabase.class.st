Class {
	#name : #GtApLepiterDatabase,
	#superclass : #Object,
	#instVars : [
		'rawData',
		'server',
		'token',
		'pages',
		'posts'
	],
	#category : #'LepiterClient-Model'
}

{ #category : #accessing }
GtApLepiterDatabase class >> fromRaw: aDb [
	^ self new rawData: aDb
]

{ #category : #accessing }
GtApLepiterDatabase >> description [
	^ self rawData at: 'description'
]

{ #category : #accessing }
GtApLepiterDatabase >> gtPagesFor: aView [
	<gtView>
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
GtApLepiterDatabase >> gtPostsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Posts';
		priority: 1;
		items: [ self posts ];
		column: 'Title' text: #title;
		column: 'Abstract' text: #abstract;
		column: 'Published' text: #isPublished width: 75;
		actionButtonIcon: BrGlamorousVectorIcons refresh
			tooltip: 'Update'
			action: [ :aButton :aTab | 
				self refreshPosts.
				aTab viewContentElement phlow update ]
]

{ #category : #accessing }
GtApLepiterDatabase >> gtRawDataFor: aView [
	<gtView>
	^ aView columnedTree
		title: 'Raw data';
		priority: 40;
		items: [ rawData associations ];
		column: 'Property' text: #key;
		column: 'Value' text: #value;
		children: [ :each | 
			each value isDictionary
				ifTrue: [ each value associations ]
				ifFalse: [ (each value isArray and: [ each value allSatisfy: #isDictionary ])
						ifTrue: [ each value collectWithIndex: [ :x :i | i -> x ] ]
						ifFalse: [ #() ] ] ];
		send: #value
]

{ #category : #accessing }
GtApLepiterDatabase >> id [
	^ self rawData at: 'id' at: 'uuid'
]

{ #category : #accessing }
GtApLepiterDatabase >> lepiterDatabase [
	^ self rawData at: 'ledatabase' at: 'uuid'
]

{ #category : #accessing }
GtApLepiterDatabase >> location [
	^ self server , '/' , self slug
]

{ #category : #accessing }
GtApLepiterDatabase >> name [
	^ self rawData at: 'name'
]

{ #category : #accessing }
GtApLepiterDatabase >> pageByUuid: aUuid [
	^ self pages detect: [ :aPage | aPage uid = aUuid ]
]

{ #category : #accessing }
GtApLepiterDatabase >> pages [
	^ pages ifNil: [ self refreshPages ]
]

{ #category : #accessing }
GtApLepiterDatabase >> posts [
	^ posts ifNil: [ self refreshPosts ]
]

{ #category : #accessing }
GtApLepiterDatabase >> rawData [
	^ rawData
]

{ #category : #accessing }
GtApLepiterDatabase >> rawData: anObject [
	rawData := anObject
]

{ #category : #accessing }
GtApLepiterDatabase >> refreshPages [
	^ pages := (ZnClient new beOneShot
			url: self server , '/api/pages?database='
					, (self rawData at: 'ledatabase' at: 'uuid');
			setBearerAuthentication: self token;
			get;
			response) entity string
			readStreamDo: [ :aStream | LeJsonV4 uniqueInstance deserialize: aStream ]
]

{ #category : #accessing }
GtApLepiterDatabase >> refreshPosts [
	^ posts := (((ZnClient new beOneShot
			url: self server , '/api/posts?database=' , self slug;
			get;
			response) entity string
			readStreamDo: [ :aStream | LeJsonV4 uniqueInstance deserialize: aStream ])
			at: 'posts') collect: [ :aPost | aPost database: self ]
]

{ #category : #accessing }
GtApLepiterDatabase >> server [
	^ server
]

{ #category : #accessing }
GtApLepiterDatabase >> server: anObject [
	server := anObject
]

{ #category : #accessing }
GtApLepiterDatabase >> slug [
	^ self rawData at: 'slug'
]

{ #category : #accessing }
GtApLepiterDatabase >> token [
	^ token
]

{ #category : #accessing }
GtApLepiterDatabase >> token: anObject [
	token := anObject
]
