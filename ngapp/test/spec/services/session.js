'use strict';

describe('Service: Session', function () {

  // load the service's module
  beforeEach(module('wordhubApp'));

  // instantiate service
  var Session, $cookies,
    sessionKey = 'wordhubAngularSession',
    user = {email: 'some@example.com'};
  beforeEach(inject(function (_Session_, _$cookies_) {
    Session = _Session_;
    $cookies = _$cookies_;
  }));

  describe('signin and signout', function () {
    it('stores the user in a cookie', function () {
      Session.signIn(user);
      expect($cookies[sessionKey]).toEqual(JSON.stringify(user));
      expect(Session.currentUser()).toEqual(user);
      expect(Session.isSignedIn()).toBe(true);

      Session.signOut();
      expect($cookies[sessionKey]).toBeUndefined();
      expect(Session.currentUser()).toEqual(null);
      expect(Session.isSignedIn()).toBe(false);
    });
  });
});
