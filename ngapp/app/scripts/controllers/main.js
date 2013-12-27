'use strict';

angular.module('wordhubApp')
  .controller('MainCtrl', function ($scope, $http) {
    $http.get('/api/users.json')
      .success(function (data) {
        $scope.users = data;
      });
  });
