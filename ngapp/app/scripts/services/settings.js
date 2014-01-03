'use strict';

angular.module('wordhubApp')
  .constant('SETTINGS', {
    sessionCookie: 'wordhubAngularSession',
    defaultRoute: '/',
    defaultSignedInRoute: '/flashcards',
    devAppRoot: '/',
    productionAppRoot: '/angular/',
    linkRoot: './#!',
    initialYear: 2013,
    customErrorEvent: 'event:customError',
    broadcastBackendError: function (scope, translate) {
      return function () {
        // TODO: substitute event name with a reference
        // to SETTINGS.customErrorEvent.
        scope.$broadcast('event:customError', translate('flash.networkError'));
      };
    }
  });
