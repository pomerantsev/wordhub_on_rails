'use strict';

angular.module('wordhubApp')
  .controller('EditFlashcardCtrl', function (Flashcard, $routeParams) {
    var ctrl = this;
    ctrl.flashcard = Flashcard.get({id: $routeParams.id});
  });
