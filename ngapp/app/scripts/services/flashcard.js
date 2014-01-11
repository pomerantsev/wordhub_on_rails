'use strict';

angular.module('wordhubApp')
  .factory('Flashcard', function ($resource, $rootScope, Session) {
    var resource = $resource('/api/flashcards/:id.json', {id: '@id'}, {
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
