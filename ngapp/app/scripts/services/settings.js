'use strict';

angular.module('wordhubApp')
  .constant('SETTINGS', {
    sessionCookie: 'wordhubAngularSession',
    defaultRoute: '/',
    defaultSignedInRoute: '/flashcards',
    initialYear: 2013
  });
