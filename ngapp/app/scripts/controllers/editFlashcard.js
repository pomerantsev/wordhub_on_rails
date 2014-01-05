'use strict';

angular.module('wordhubApp')
  .controller('EditFlashcardCtrl', function (Flashcard, $routeParams, $location, SETTINGS) {
    var ctrl = this;
    ctrl.flashcard = Flashcard.get({id: $routeParams.id});
    ctrl.update = function () {
      ctrl.submitting = true;
      ctrl.flashcard.$patch()
        .then(function () {
          $location.path(SETTINGS.routes.flashcardsPath).hash(ctrl.flashcard.id);
        })
        .finally(function () {
          ctrl.submitting = false;
        });
    };
  });
