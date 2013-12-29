'use strict';

window.app.factory('Auth', function ($http) {
  return {
    signIn: function (credentials) {
      return $http.post('/api/login.json',
        {email: credentials.email, password: credentials.password});
    }
  };
});
