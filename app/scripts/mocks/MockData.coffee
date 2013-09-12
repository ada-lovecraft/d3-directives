services = angular.module 'app.mocks'
services.factory 'MockData', ['$http', ($http) ->
	return {
		tonight: ->
			$http.get('/frontOffice/tonight/')
	}
]