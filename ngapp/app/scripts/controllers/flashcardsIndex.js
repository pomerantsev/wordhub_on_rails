'use strict';

app.controller('FlashcardsIndexCtrl', function ($http) {
  this.flashcards = [];
  var that = this;
  $http.get('/api/flashcards.json')
    .success(function (data) {
      angular.forEach(data, function (flashcard) {
        console.log(data);
        that.flashcards.push({id: flashcard.id, frontText: flashcard.front_text, backText: flashcard.back_text});
      });
    });
});
