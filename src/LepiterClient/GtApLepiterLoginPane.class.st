Class {
	#name : #GtApLepiterLoginPane,
	#superclass : #Object,
	#instVars : [
		'onLogin',
		'server',
		'username',
		'password'
	],
	#category : #'LepiterClient-UI'
}

{ #category : #accessing }
GtApLepiterLoginPane >> asElement [
	^ self asGtMagritteViewModel asElement
]

{ #category : #accessing }
GtApLepiterLoginPane >> initialize [
	self server: ''.
	self username: ''.
	self password: ''
]

{ #category : #accessing }
GtApLepiterLoginPane >> magritteAcceptAction [
	<magritteActionDescription>
	^ super magritteAcceptAction
		onSuccessCallback: (GtMagritteCallback new
				action: [ :aModel :aButton :aMemento :aDescription | 
					| loginResult |
					loginResult := STONJSON
							fromString: (ZnEasy
									post: self server , '/api/loginUser'
									data: (ZnEntity
											json: (STONJSON
													toString: {'username' -> self username.
															'password' -> self password} asDictionary))) entity string.
					self onLogin value: self server -> (loginResult at: 'token') ])
]

{ #category : #accessing }
GtApLepiterLoginPane >> onLogin [
	^ onLogin
]

{ #category : #accessing }
GtApLepiterLoginPane >> onLogin: anObject [
	onLogin := anObject
]

{ #category : #accessing }
GtApLepiterLoginPane >> password [
	^ password
]

{ #category : #accessing }
GtApLepiterLoginPane >> password: anObject [
	password := anObject
]

{ #category : #accessing }
GtApLepiterLoginPane >> passwordDescription [
	<magritteDescription>
	^ MAPasswordDescription new
		priority: 3;
		label: 'Password';
		accessor: #password
]

{ #category : #accessing }
GtApLepiterLoginPane >> server [
	^ server
]

{ #category : #accessing }
GtApLepiterLoginPane >> server: anObject [
	server := anObject
]

{ #category : #accessing }
GtApLepiterLoginPane >> serverDescription [
	<magritteDescription>
	^ MAStringDescription new
		priority: 1;
		label: 'Server';
		accessor: #server
]

{ #category : #accessing }
GtApLepiterLoginPane >> username [
	^ username
]

{ #category : #accessing }
GtApLepiterLoginPane >> username: anObject [
	username := anObject
]

{ #category : #accessing }
GtApLepiterLoginPane >> usernameDescription [
	<magritteDescription>
	^ MAStringDescription new
		priority: 2;
		label: 'Username';
		accessor: #username
]
