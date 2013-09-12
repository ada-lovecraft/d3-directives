services = angular.module 'app.services'
services.factory 'MockService', ['MockRepo','$q', ($MockRepo,$q) ->
	return {
		getTonight: ->
			deferred = $q.defer()

			console.log 'getting Tonight'
			$MockRepo.getTonight().then (data) ->
				console.log 'lol:',data
				deferred.resolve(data)

			return deferred.promise
	}
]