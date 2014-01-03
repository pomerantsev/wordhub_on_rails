'use strict';

angular.module('wordhubApp', [
  'ngCookies',
  'ngResource',
  'ngRoute',
  'pascalprecht.translate',
  // Add a config module for using different backends
  // for development and production:
  // http://stackoverflow.com/questions/16339595/angular-js-configuration-for-different-enviroments
  'config'
])
  .config(function ($routeProvider, SETTINGS) {
    $routeProvider
      .when('/', {
        templateUrl: 'views/main.html',
        controller: 'MainCtrl as main',
        resolve: {
          isNotSignedIn: ['$q', 'Session', '$location',
            function ($q, Session, $location) {
              var defer = $q.defer();
              if (Session.isSignedIn()) {
                $location.path(SETTINGS.defaultSignedInRoute);
              }
              defer.resolve();
              return defer.promise;
            }]
        }
      })
      .when(SETTINGS.routes.flashcardsPath, {
        templateUrl: 'views/flashcardsIndex.html',
        controller: 'FlashcardsIndexCtrl as flashcardsIndex'
        // TODO: use a resolve object here too
      })
      .when(SETTINGS.routes.newFlashcardPath, {
        templateUrl: 'views/newFlashcard.html',
        controller: 'NewFlashcardCtrl as newFlashcard'
        // TODO: use a resolve object here too
      })
      .otherwise({
        redirectTo: SETTINGS.defaultRoute
      });
  })
  .config(function ($translateProvider, EN_TRANSLATIONS, RU_TRANSLATIONS) {
    $translateProvider
      .translations('en', EN_TRANSLATIONS)
      .translations('ru', RU_TRANSLATIONS);
  })
  .config(function ($locationProvider) {
    $locationProvider.html5Mode(false).hashPrefix('!');
  })
  .config(function ($httpProvider, $provide) {
    $provide.factory('interceptor', ['$rootScope', '$q', function ($rootScope, $q) {
      return {
        responseError: function (rejection) {
          if (rejection.status === 401) {
            $rootScope.$broadcast('event:unauthorized');
          }
          return $q.reject(rejection);
        }
      };
    }]);
    $httpProvider.interceptors.push('interceptor');
  })
  .run(function ($location, $translate, ENV, $rootScope, Session, SETTINGS) {
    /* Private helper methods */
    var setLocaleByCurrentUser = function () {
      $translate.uses(Session.currentUser().interfaceLanguage);
    };
    var setLocaleByDomain = function () {
      if ($location.host() === 'localhost') {
        $translate.uses('ru');
      } else {
        $translate.uses('en');
      }
    };

    /* Initializers */
    // Set initial locale
    if (Session.isSignedIn()) {
      setLocaleByCurrentUser();
    } else {
      setLocaleByDomain();
    }
    // Set app root
    if (ENV === 'production') {
      $rootScope.appRoot = SETTINGS.productionAppRoot;
    } else if (ENV === 'development') {
      $rootScope.appRoot = SETTINGS.devAppRoot;
    }
    // Set link root (in case $locationProvider settings change)
    $rootScope.linkRoot = SETTINGS.linkRoot;

    /* Event handlers */
    $rootScope.$on('event:unauthorized', function () {
      Session.signOut();
    });
    $rootScope.$on('event:signedIn', function () {
      setLocaleByCurrentUser();
      $location.path(SETTINGS.defaultSignedInRoute);
    });
    $rootScope.$on('event:signedOut', function () {
      setLocaleByDomain();
      $location.path(SETTINGS.defaultRoute);
    });
  });
