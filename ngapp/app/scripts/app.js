'use strict';

angular.module('wordhubApp', [
  'ngCookies',
  'ngResource',
  'ngRoute',
  'pascalprecht.translate'
])
  .config(function ($routeProvider) {
    $routeProvider
      .when('/', {
        templateUrl: 'views/main.html',
        controller: 'MainCtrl'
      })
      .otherwise({
        redirectTo: '/'
      });
  })
  .config(function ($translateProvider) {
    $translateProvider.translations('ru', {
      NAV: {
        CREATE: 'Создать',
        OF: 'из'
      }
    }).translations('en', {
      NAV: {
        CREATE: 'Create',
        OF: 'of'
      }
    });
  })
  .run(function ($location, $translate) {
    var host = $location.host();
    if (host === 'localhost') {
      $translate.uses('ru');
    } else {
      $translate.uses('en');
    }
  });
