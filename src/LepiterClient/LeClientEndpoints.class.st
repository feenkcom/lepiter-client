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
LeClientEndpoints class >> apiLoginUser [
	^ '/api/loginUser'
]

{ #category : #accessing }
LeClientEndpoints class >> apiPage [
	^ '/api/page'
]

{ #category : #accessing }
LeClientEndpoints class >> apiUpdateAttachment [
	^ '/api/updateAttachment'
]

{ #category : #accessing }
LeClientEndpoints class >> serverUrl [
	^ 'https://lepiter.io' asZnUrl
]
