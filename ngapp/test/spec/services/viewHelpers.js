'use strict';

describe('Service: ViewHelpers', function () {

  // load the service's module
  beforeEach(module('wordhubApp'));

  // instantiate service
  var ViewHelpers, SETTINGS;
  beforeEach(inject(function (_ViewHelpers_, _SETTINGS_) {
    ViewHelpers = _ViewHelpers_;
    SETTINGS = _SETTINGS_;
  }));

  describe('#getCopyrightYears', function () {
    describe('when current year is the initial year', function () {
      it('returns the initial year', function () {
        expect(ViewHelpers.getCopyrightYears(SETTINGS.initialYear))
          .toEqual(SETTINGS.initialYear);
      });
    });
    describe('when current year is greater than the initial year', function () {
      it('returns a string with an &mdash;', function () {
        expect(ViewHelpers.getCopyrightYears(SETTINGS.initialYear + 1))
          .toEqual(
            SETTINGS.initialYear +
              '—' +
              (SETTINGS.initialYear + 1)
          );
      });
    });
  });

});
