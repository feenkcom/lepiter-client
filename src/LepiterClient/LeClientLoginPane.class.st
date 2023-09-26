Class {
	#name : #LeClientLoginPane,
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
LeClientLoginPane >> asElement [
	^ self asGtMagritteViewModel asElement
]

{ #category : #accessing }
LeClientLoginPane >> initialize [
	self server: ''.
	self username: ''.
	self password: ''
]

{ #category : #accessing }
LeClientLoginPane >> magritteAcceptAction [
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
LeClientLoginPane >> onLogin [
	^ onLogin
]

{ #category : #accessing }
LeClientLoginPane >> onLogin: anObject [
	onLogin := anObject
]

{ #category : #accessing }
LeClientLoginPane >> password [
	^ password
]

{ #category : #accessing }
LeClientLoginPane >> password: anObject [
	password := anObject
]

{ #category : #accessing }
LeClientLoginPane >> passwordDescription [
	<magritteDescription>
	^ MAPasswordDescription new
		priority: 3;
		label: 'Password';
		accessor: #password
]

{ #category : #accessing }
LeClientLoginPane >> server [
	^ server
]

{ #category : #accessing }
LeClientLoginPane >> server: anObject [
	server := anObject
]

{ #category : #accessing }
LeClientLoginPane >> serverDescription [
	<magritteDescription>
	^ MAStringDescription new
		priority: 1;
		label: 'Server';
		accessor: #server
]

{ #category : #accessing }
LeClientLoginPane >> username [
	^ username
]

{ #category : #accessing }
LeClientLoginPane >> username: anObject [
	username := anObject
]

{ #category : #accessing }
LeClientLoginPane >> usernameDescription [
	<magritteDescription>
	^ MAStringDescription new
		priority: 2;
		label: 'Username';
		accessor: #username
]
