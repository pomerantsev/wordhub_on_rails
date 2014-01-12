'use strict';

angular.module('wordhubApp', [
  'ngCookies',
  'ngResource',
  'ngRoute',
  'pascalprecht.translate',
  'ui.bootstrap.collapse',
  'ui.bootstrap.dropdownToggle',
  // Add a config module for using different backends
  // for development and production:
  // http://stackoverflow.com/questions/16339595/angular-js-configuration-for-different-enviroments
  'config'
])
  .config(function ($routeProvider, SETTINGS) {
    var getXsrfToken = ['$cookies', '$http', '$q', function ($cookies, $http, $q) {
      if($cookies['XSRF-TOKEN']) {
        return $q.when();
      } else {
        return $http.get('/api/xsrf-token.json');
      }
    }];
    var checkIfSignedIn = ['Auth', function (Auth) {
      return Auth.check();
    }];
    var checkIfNotSignedIn = ['Auth', '$location', '$q', function (Auth, $location, $q) {
      var defer = $q.defer();
      Auth.check()
        .then(function () {
          $location.path(SETTINGS.defaultSignedInRoute);
        }, function () {
          defer.resolve();
        });
      return defer.promise;
    }];
    $routeProvider
      .when('/', {
        templateUrl: 'views/main.html',
        controller: 'MainCtrl as main',
        resolve: {
          isNotSignedIn: checkIfNotSignedIn,
          xsrfToken: getXsrfToken
        }
      })
      .when(SETTINGS.routes.flashcardsPath, {
        templateUrl: 'views/flashcardsIndex.html',
        controller: 'FlashcardsIndexCtrl as flashcardsIndex',
        resolve: {
          signedIn: checkIfSignedIn,
          xsrfToken: getXsrfToken
        }
      })
      .when(SETTINGS.routes.newFlashcardPath, {
        templateUrl: 'views/newFlashcard.html',
        controller: 'NewFlashcardCtrl as newFlashcard',
        resolve: {
          signedIn: checkIfSignedIn,
          xsrfToken: getXsrfToken
        }
      })
      .when(SETTINGS.routes.editFlashcardPathMask, {
        templateUrl: 'views/editFlashcard.html',
        controller: 'EditFlashcardCtrl as editFlashcard',
        resolve: {
          signedIn: checkIfSignedIn,
          xsrfToken: getXsrfToken
        }
      })
      .when(SETTINGS.routes.repetitionsPath, {
        templateUrl: 'views/repetitions.html',
        controller: 'RepetitionsCtrl as repetitions',
        resolve: {
          signedIn: checkIfSignedIn,
          xsrfToken: getXsrfToken
        }
      })
      .when(SETTINGS.routes.signupPath, {
        templateUrl: 'views/signup.html',
        controller: 'SignupCtrl as signup',
        resolve: {
          isNotSignedIn: checkIfNotSignedIn,
          xsrfToken: getXsrfToken
        }
      })
      .when(SETTINGS.routes.statsPath, {
        templateUrl: 'views/stats.html',
        controller: 'StatsCtrl as stats',
        resolve: {
          signedIn: checkIfSignedIn,
          xsrfToken: getXsrfToken
        }
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
  .config(function ($httpProvider, $provide, SETTINGS) {
    $provide.factory('interceptor', ['$rootScope', '$q', function ($rootScope, $q) {
      return {
        responseError: function (rejection) {
          if (rejection.status === 401) {
            $rootScope.$broadcast('event:unauthorized');
          } else if (rejection.status === 500) {
            $rootScope.$broadcast(SETTINGS.customErrorEvent, rejection);
          }
          return $q.reject(rejection);
        }
      };
    }]);
    $httpProvider.interceptors.push('interceptor');
  })
  .run(function ($location, $translate, ENV, $rootScope, Session, SETTINGS, $routeParams, $anchorScroll) {
    /* Private helper methods */
    var setLocaleByCurrentUser = function () {
      $translate.uses(Session.currentUser().interfaceLanguage);
    };
    var setLocaleByDomain = function () {
      var domains = $location.host().split('.');
      var tld = domains[domains.length - 1];
      if (tld === 'com' || tld === 'org') {
        $translate.uses('en');
      } else if (tld === 'ru') {
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
      $rootScope.$broadcast(SETTINGS.customErrorEvent, $translate('flash.unauthorized'));
    });
    $rootScope.$on('$routeChangeSuccess', function() {
      $location.hash($routeParams.scrollTo);
      $anchorScroll();
    });
    $rootScope.$watch(function () {
      return Session.isSignedIn();
    }, function (isSignedIn) {
      if (isSignedIn) {
        setLocaleByCurrentUser();
        $location.path(SETTINGS.defaultSignedInRoute);
      } else {
        setLocaleByDomain();
        $location.path(SETTINGS.defaultRoute);
      }
    });
  });
