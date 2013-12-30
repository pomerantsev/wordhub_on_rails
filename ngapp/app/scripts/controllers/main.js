'use strict';

angular.module('wordhubApp')
  .controller('MainCtrl', function (Auth) {
    this.credentials = {};
    this.login = function () {
      Auth.signIn(this.credentials);
    };
  });
