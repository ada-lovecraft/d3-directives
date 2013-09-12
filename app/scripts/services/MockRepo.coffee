services = angular.module 'app.repos'
services.factory 'MockRepo', ['$http', ($http) ->
	return {
		getTonight: ->
			$http.get('/frontOffice/tonight/')
	}
]