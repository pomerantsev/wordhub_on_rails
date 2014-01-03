'use strict';

angular.module('wordhubApp')
  .factory('Flashcard', function ($resource) {
    return $resource('/api/flashcards/:id.json', {}, {
      save: {
        method: 'POST',
        transformRequest: function (data) {
          data = {
            flashcard: {
              front_text: data.frontText,
              back_text: data.backText
            }
          };
          return JSON.stringify(data);
        }
      }
    });
  });
