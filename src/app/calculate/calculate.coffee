'use strict'

# module definition
# ------------------------------------------------------------
angular.module('hoay.calculate', [])

# config
# ------------------------------------------------------------
.config([
  '$routeProvider',
  ($routeProvider) ->
    $routeProvider
      .when '/',
        controller: 'calculateController',
        templateUrl: 'calculate/calculate.tpl.html'
])

# controller
# ------------------------------------------------------------
.controller 'calculateController',[
  '$scope',
  '$navigate',
  '$log',
  '$translate',
  'DateModel'
  ($scope, $navigate, $log, $translate, dateModel)->

    init = ->
      # set initial dates
      # TODO: using cookies to get prev. dates
      $scope.dateModel = dateModel
      dateModel.setStart new Date(1978, 6, 30 )
      dateModel.setEnd new Date()

    $scope.showResult = ->
      $navigate.go '/result'

    $scope.showSettings = ->
      $navigate.go '/settings', 'modal'

    $scope.showInfo = ->
      $navigate.go '/info', 'modal'

    init()
]


