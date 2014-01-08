'use strict';

describe('Service: Session', function () {

  // load the service's module
  beforeEach(module('wordhubApp'));

  // instantiate service
  var Session, $cookies,
    sessionKey = 'wordhubAngularSession',
    user = {email: 'some@example.com'};
  beforeEach(inject(function (_Session_) {
    Session = _Session_;
  }));

  describe('signin and signout', function () {
    it('stores the current user', function () {
      Session.signIn(user);
      expect(Session.currentUser()).toEqual(user);
      expect(Session.isSignedIn()).toBe(true);

      Session.signOut();
      expect(Session.currentUser()).toEqual(null);
      expect(Session.isSignedIn()).toBe(false);
    });
  });
});
