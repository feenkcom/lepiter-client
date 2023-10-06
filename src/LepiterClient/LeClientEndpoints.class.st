Class {
	#name : #LeClientEndpoints,
	#superclass : #Object,
	#category : #'LepiterClient-Client New'
}

{ #category : #accessing }
LeClientEndpoints class >> apiAttachment [
	^ '/api/attachment'
]

{ #category : #accessing }
LeClientEndpoints class >> apiCreateAttachment [
	^ '/api/createAttachment'
]

{ #category : #accessing }
LeClientEndpoints class >> apiCreateFile [
	^ '/api/createFile'
]

{ #category : #accessing }
LeClientEndpoints class >> apiCreatePage [
	^ '/api/createPage'
]

{ #category : #accessing }
LeClientEndpoints class >> apiCreatePost [
	^ '/api/createPost'
]

{ #category : #accessing }
LeClientEndpoints class >> apiDatabases [
	^ '/api/databases'
]

{ #category : #accessing }
LeClientEndpoints class >> apiLoginUser [
	^ '/api/loginUser'
]

{ #category : #accessing }
LeClientEndpoints class >> apiPage [
	^ '/api/page'
]

{ #category : #accessing }
LeClientEndpoints class >> apiPostByPage [
	^ '/api/postByPage'
]

{ #category : #accessing }
LeClientEndpoints class >> apiUpdateAttachment [
	^ '/api/updateAttachment'
]

{ #category : #accessing }
LeClientEndpoints class >> apiUpdatePage [
	^ '/api/updatePage'
]

{ #category : #accessing }
LeClientEndpoints class >> apiUpdatePost [
	^ '/api/updatePost'
]

{ #category : #accessing }
LeClientEndpoints class >> gtEndpointsFor: aView [
	<gtClassView>
	^ aView columnedList
		title: 'Endpoints';
		priority: 30;
		items: [ (self classSide methods select: [ :each | each numArgs = 0 ])
				sort: [ :a :b | a selector < b selector ] ];
		column: 'Endpoint' text: [ :aMethod | self perform: aMethod selector ];
		send: [ :aMethod | 
			| aString |
			aString := (self perform: aMethod selector) asString.
			(aString beginsWith: '/') ifTrue: [ aString := aString allButFirst ].
			aMethod selector gtSenders
				| (aString gtSubstringLiteralCaseSensitiveMatch
						& self classSide gtMethodsInClass not) ]
]

{ #category : #accessing }
LeClientEndpoints class >> serverUrl [
	^ 'https://lepiter.io' asZnUrl
]
