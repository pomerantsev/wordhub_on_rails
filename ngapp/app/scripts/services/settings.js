'use strict';

angular.module('wordhubApp')
  .constant('SETTINGS', {
    sessionCookie: 'wordhubAngularSession',
    defaultRoute: '/',
    // TODO: substitute with a named route
    defaultSignedInRoute: '/flashcards/new',
    routes: {
      flashcardsPath: '/flashcards',
      newFlashcardPath: '/flashcards/new',
      editFlashcardPathMask: '/flashcards/:id/edit',
      editFlashcardPath: function (id) {
        return '/flashcards/' + id + '/edit';
      }
    },
    devAppRoot: '/',
    productionAppRoot: '/angular/',
    linkRoot: './#!',
    initialYear: 2013,
    customErrorEvent: 'event:customError'
  });
