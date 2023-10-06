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
LeClientEndpoints class >> serverUrl [
	^ 'https://lepiter.io' asZnUrl
]
