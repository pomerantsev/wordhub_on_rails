'use strict';

var app = angular.module('wordhubApp', [
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
      .when('/flashcards', {
        templateUrl: 'views/flashcardsIndex.html',
        controller: 'FlashcardsIndexCtrl as flashcardsIndex'
      })
      .otherwise({
        redirectTo: '/'
      });
  })
  .config(function ($translateProvider) {
    $translateProvider.translations('ru', {
      nav: {
        create: 'Создать',
        of: 'из',
        allFlashcards: 'Все карточки'
      }
    }).translations('en', {
      nav: {
        create: 'Create',
        of: 'of',
        allFlashcards: 'All flashcards'
      }
    });
  })
  .config(function ($locationProvider) {
    $locationProvider.html5Mode(false).hashPrefix('!');
  })
  .run(function ($location, $translate) {
    var host = $location.host();
    if (host === 'localhost') {
      $translate.uses('ru');
    } else {
      $translate.uses('en');
    }
  });
