'use strict';

angular.module('wordhubApp')
  .factory('RepetitionStore', function () {
    var _store;
    return {
      query: function () {
        return _store;
      },
      saveAll: function (repetitions) {
        _store = repetitions;
      },
      removeRepetition: function (repetition) {
        angular.forEach(_store, function (value, index) {
          if (value.id === repetition.id) {
            _store.splice(index, 1);
          }
        });
      },
      getLength: function () {
        return _store && _store.length;
      }
    };
  });
