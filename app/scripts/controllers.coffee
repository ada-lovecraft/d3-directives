'use strict'

### Controllers ###

angular.module('app.controllers', [])

.controller('AppCtrl', [
  '$scope'
  '$location'
  '$resource'
  '$rootScope'

($scope, $location, $resource, $rootScope) ->

  # Uses the url to determine if the selected
  # menu item should have the class active.
  $scope.$location = $location
  $scope.$watch('$location.path()', (path) ->
    $scope.activeNavId = path || '/'
  )

  # getClass compares the current url with the id.
  # If the current url starts with the id it returns 'active'
  # otherwise it will return '' an empty string. E.g.
  #
  #   # current url = '/products/1'
  #   getClass('/products') # returns 'active'
  #   getClass('/orders') # returns ''
  #
  $scope.getClass = (id) ->
    if $scope.activeNavId.substring(0, id.length) == id
      return 'active'
    else
      return ''
])

.controller('MainController', [
  '$scope'
  'MockService'
($scope,$MockService) ->
  @original = true

  console.log 'mockService:', $MockService
  $MockService.getTonight().then (data) ->
    console.log 'tonight response: ' , data
    $scope.tonight = data.data
    $scope.pieData = [
        label: 'Occupied'
        tag: 'occupied'
        value: Math.floor($scope.tonight.occupied)
      ,
        label: 'Available'
        tag: 'available'
        value: 100 - Math.floor($scope.tonight.occupied)
    ]

  $scope.d3Data = $scope.data1


])

