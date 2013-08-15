# module definition
# ------------------------------------------------------------
angular.module('hoay.calculate', [
  'jm.i18next'
])

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
  '$window',
  '$scope',
  '$navigate',
  '$log',
  '$i18next',
  'DateModel'
  ($window, $scope, $navigate, $log, $i18next, dateModel)->

    init = ->
      $scope.dateModel = dateModel

    # navigation
    # ------------------------------------------------------------

    $scope.showResult = ->
      $navigate.go '/result'

    $scope.showSettings = ->
      $navigate.go '/settings', 'modal'

    $scope.showInfo = ->
      $navigate.go '/info', 'modal'

    # date handling
    # ------------------------------------------------------------

    $scope.changeStartDate = ->
      date = $scope.dateModel.start
      if $window.cordova
        maxMoment = moment($scope.dateModel.end).subtract 'days', 1
        maxDate = new Date maxMoment
        options =
          date: date
          maxDate: maxDate
          mode: 'date'

        datePicker.show options, changeStartDateHandler
      else
        #TODO: Add date picker for web

    changeStartDateHandler = (date) ->
      $scope.$apply( ->
        $scope.dateModel.setStart date
      )

    $scope.changeEndDate = ->
      date = $scope.dateModel.end
      if $window.cordova
        minMoment = moment($scope.dateModel.start).add 'days', 1
        minDate = new Date minMoment
        options =
          date: date
          allowOldDates: false
          minDate: minDate
          mode: 'date'

        datePicker.show options, changeEndDateHandler
      else
        #TODO: Add date picker for web

    changeEndDateHandler = (date) ->
      $scope.$apply( ->
        $scope.dateModel.setEnd date
      )

    # error handling
    # ------------------------------------------------------------

    $scope.showError = ->
      $scope.errorMessage = $i18next 'common.EROR_ENDDATE_BEFORE_STARTDATE'

    $scope.hideError = ->
      $scope.errorMessage = ''

    $scope.hasError = ->
      $scope.errorMessage isnt undefined and $scope.errorMessage isnt ''


    init()
]


