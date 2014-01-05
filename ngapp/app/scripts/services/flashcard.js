'use strict';

angular.module('wordhubApp')
  .factory('Flashcard', function ($resource, $rootScope) {
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
        },
        interceptor: {
          response: function (response) {
            $rootScope.$broadcast('event:flashcardCreated');
            return response;
          }
        }
      },
      patch: {
        method: 'PATCH',
        params: {id: "@id"},
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
