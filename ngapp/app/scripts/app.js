'use strict';

var app = angular.module('wordhubApp', [
  'ngCookies',
  'ngResource',
  'ngRoute',
  'pascalprecht.translate',
  // Add a config module for using different backends
  // for development and production:
  // http://stackoverflow.com/questions/16339595/angular-js-configuration-for-different-enviroments
  'config'
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
      },
      application: {
        index: {
          header: 'Простой способ учить иностранные слова',
          subheader: 'Как бумажные карточки, только удобнее.'
        }
      }
    }).translations('en', {
      nav: {
        create: 'Create',
        of: 'of',
        allFlashcards: 'All flashcards'
      },
      application: {
        index: {
          header: 'A simple way to memorize foreign words',
          subheader: 'Just like paper flashcards, but much more convenient.'
        }
      }
    });
  })
  .config(function ($locationProvider) {
    $locationProvider.html5Mode(false).hashPrefix('!');
  })
  .config(function ($httpProvider, $provide) {
    $provide.factory('interceptor', ['$rootScope', '$q', function ($rootScope, $q) {
      return {
        responseError: function (rejection) {
          if (rejection.status == 401) {
            $rootScope.$broadcast('event:unauthorized');
          }
          return $q.reject(rejection);
        }
      };
    }]);
    $httpProvider.interceptors.push('interceptor');
  })
  .run(function ($location, $translate, ENV, $rootScope) {
    $rootScope.$on('event:unauthorized', function () {
      $location.path('/');
    });
    var setLocale = function () {
      var host = $location.host();
      if (host === 'localhost') {
        $translate.uses('ru');
      } else {
        $translate.uses('en');
      }
    };
    var setAppRoot = function () {
      if (ENV === 'production') {
        $rootScope.appRoot = '/angular/';
      } else if (ENV === 'development') {
        $rootScope.appRoot = '/';
      }
    };
    var setLinkRoot = function () {
      $rootScope.linkRoot = './#!';
    };
    setLocale();
    setAppRoot();
    setLinkRoot();
  });
