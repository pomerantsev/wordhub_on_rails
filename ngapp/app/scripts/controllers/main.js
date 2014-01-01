'use strict';

angular.module('wordhubApp')
  .controller('MainCtrl', function (Auth, $rootScope, $translate) {
    this.credentials = {};
    this.signIn = function () {
      Auth.signIn(this.credentials)
        .then(function (data) {
          if (!data.success) {
            $rootScope.$broadcast('event:customError', $translate('flash.userNotRegistered'));
          }
        });
    };
  });
