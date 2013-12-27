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
      nav: {
        create: 'Создать',
        of: 'из'
      }
    }).translations('en', {
      nav: {
        create: 'Create',
        of: 'of'
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
