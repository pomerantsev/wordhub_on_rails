'use strict';

app.controller('FlashcardsIndexCtrl', function ($http) {
  var that = this;
  $http.get('/api/users.json')
    .success(function (data) {
      that.flashcards = [];
      angular.forEach(data, function (user) {
        that.flashcards.push({frontText: user.email, backText: user.name});
      });
    });
});
