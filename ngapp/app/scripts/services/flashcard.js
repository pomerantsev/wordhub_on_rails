'use strict';

angular.module('wordhubApp')
  .factory('Flashcard', function ($resource, $rootScope, Session) {
    var resourceRoot = '/api/flashcards';
    var resource = $resource(resourceRoot + '/:id.json', {id: '@id'}, {
      query: {
        method: 'GET',
        isArray: false
      },
      save: {
        method: 'POST',
        transformRequest: function (data) {
          Session.changeCreatedTodayBy(1);
          data = {
            flashcard: {
              front_text: data.frontText,
              back_text: data.backText
            }
          };
          return JSON.stringify(data);
        }
      },
      patch: {
        method: 'PATCH',
        transformRequest: function (data) {
          data = {
            flashcard: {
              front_text: data.frontText,
              back_text: data.backText
            }
          };
          return JSON.stringify(data);
        }
      },
      undelete: {
        method: 'PATCH',
        url: resourceRoot + '/undelete.json'
      }
    });

    resource.deleteFlashcard = function (flashcard) {
      if (flashcard.isCreatedToday) {
        Session.changeCreatedTodayBy(-1);
      }
      return flashcard.$delete();
    };

    return resource;
  });
