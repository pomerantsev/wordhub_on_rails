'use strict';

angular.module('wordhubApp')
  .factory('Flashcard', function ($resource) {
    return $resource('/api/flashcards/:id.json');
  });
