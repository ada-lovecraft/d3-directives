'use strict'

# Declare app level module which depends on filters, and services
angular.module('app.directives', [])
angular.module('app.repos',[])
angular.module('app.services', [])
angular.module('app.mocks', [])


App = angular.module('app', [
  'ngCookies'
  'ngResource'
  'app.controllers'
  'app.directives'
  'app.filters'
  'app.services'
  'app.repos'
  'app.mocks'
  'partials'
  'ngMockE2E'
])


App.run(['$httpBackend', ($httpBackend) ->
  console.log 'running back end'
  tonight = 
    occupied: 12
    roomsAvailable: 22
    groupPickups: 
      total: 22
      fulfilled:14
    outOfOrder: 7
  $httpBackend.when('GET','/frontOffice/tonight/').respond(tonight)
])



App.config([
  '$routeProvider'
  '$locationProvider'

($routeProvider, $locationProvider, config) ->

  $routeProvider

    .when('/todo', {templateUrl: '/partials/todo.html'})
    .when('/view1', {templateUrl: '/partials/partial1.html'})
    .when('/view2', {templateUrl: '/partials/partial2.html'})

    # Catch all
    .otherwise({redirectTo: '/todo'})

  # Without server side support html5 must be disabled.
  $locationProvider.html5Mode(false)
])
