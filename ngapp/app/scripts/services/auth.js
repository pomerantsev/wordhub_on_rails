'use strict';

window.app.factory('Auth', function ($http, Session) {
  return {
    signIn: function (credentials) {
      return $http.post('/api/login.json',
        {email: credentials.email, password: credentials.password})
        .success(function (data) {
          if (data.success) {
            Session.signIn(data.user);
          }
        });
    },
    signOut: function () {
      console.log('Before sending a DELETE request to the server');
      return $http.delete('/api/logout.json')
        .success(function (data) {
          Session.signOut();
        });
    }
  };
});
