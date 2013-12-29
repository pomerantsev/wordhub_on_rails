'use strict';

window.app.controller('MainCtrl', function (Auth) {
  this.credentials = {};
  this.login = function () {
    Auth.signIn(this.credentials);
  };
});
