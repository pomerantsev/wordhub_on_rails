'use strict';

angular.module('wordhubApp')
  .constant('SETTINGS', {
    sessionCookie: 'wordhubAngularSession',
    defaultRoute: '/',
    defaultSignedInRoute: '/flashcards',
    devAppRoot: '/',
    productionAppRoot: '/angular/',
    linkRoot: './#!',
    initialYear: 2013
  });
