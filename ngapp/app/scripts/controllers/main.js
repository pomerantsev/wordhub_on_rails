'use strict';

angular.module('wordhubApp')
  .controller('MainCtrl', function (Auth) {
    this.credentials = {};
    this.signIn = function () {
      Auth.signIn(this.credentials);
    };
  });
