Class {
	#name : #LeClientOrganization,
	#superclass : #Object,
	#instVars : [
		'context',
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
LeClientOrganization class >> leJsonV4AttributeMapping [
	^ {#name -> #name.
		#id -> #id.
		#slug -> #slug.
		#description -> #description.
		#ledatabase -> #ledatabase}
]

{ #category : #accessing }
LeClientOrganization class >> leJsonV4Name [
	^ #apServerDatabase
]

{ #category : #accessing }
LeClientOrganization >> context [
	<return: #LeClientContext>
	^ context
]

{ #category : #accessing }
LeClientOrganization >> context: leClientContext [
	context := leClientContext
]

{ #category : #accessing }
LeClientOrganization >> description [
	^ description
]

{ #category : #accessing }
LeClientOrganization >> description: anObject [
	description := anObject
]

{ #category : #accessing }
LeClientOrganization >> formatDictionary [
	^ {#name -> self name.
		#id -> self id.
		#slug -> self slug.
		#description -> self description} asDictionary
]

{ #category : #accessing }
LeClientOrganization >> gtOverviewFor: aView [
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
LeClientOrganization >> gtPagesFor: aView [
	<gtView>
	self context ifNil: [ ^ aView empty ].

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
LeClientOrganization >> gtPostsFor: aView [
	<gtView>
	self context ifNil: [ ^ aView empty ].

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
LeClientOrganization >> id [
	^ id
]

{ #category : #accessing }
LeClientOrganization >> id: anObject [
	id := anObject
]

{ #category : #accessing }
LeClientOrganization >> ledatabase [
	"Return UUID of a lepiter database instance"

	<return: #UUID>
	^ ledatabase
]

{ #category : #accessing }
LeClientOrganization >> ledatabase: anUUID [
	"Set ID of a lepiter database instance.
	This is the {{gtClass:LeDatabase}} used on the server.
	NOTE: I think users do not need to know about it. 
	The information should remain on the server side."
	
	LeClientUtility assertUUID: anUUID.
	ledatabase := anUUID
]

{ #category : #accessing }
LeClientOrganization >> lepiterDatabase [
	^ self ledatabase
]

{ #category : #accessing }
LeClientOrganization >> location [
	^ self server asZnUrl / self slug
]

{ #category : #accessing }
LeClientOrganization >> name [
	^ name
]

{ #category : #accessing }
LeClientOrganization >> name: anObject [
	name := anObject
]

{ #category : #accessing }
LeClientOrganization >> pageByUuid: aUuid [
	^ self pages detect: [ :aPage | aPage uid = aUuid ]
]

{ #category : #accessing }
LeClientOrganization >> pages [
	| command |
	command := self context client getPagesForOrganization: self.
	^ command model
]

{ #category : #accessing }
LeClientOrganization >> posts [
	| command |
	command := self context client getPostsForOrganization: self.
	^ command model at: #posts
]

{ #category : #accessing }
LeClientOrganization >> server [
	^ self context serverUrl
]

{ #category : #accessing }
LeClientOrganization >> slug [
	^ slug
]

{ #category : #accessing }
LeClientOrganization >> slug: anObject [
	slug := anObject
]

{ #category : #accessing }
LeClientOrganization >> token [
	^ self context token
]

{ #category : #accessing }
LeClientOrganization >> user [
	^ user
]

{ #category : #accessing }
LeClientOrganization >> user: anObject [
	user := anObject
]
