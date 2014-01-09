'use strict';

angular.module('wordhubApp')
  .constant('EN_TRANSLATIONS', {
    flash: {
      userNotRegistered: 'User with such email and password is not registered.',
      unauthorized: 'Your action is unauthorized. Please sign in.'
    },
    nav: {
      wordhub: 'Wordhub',
      create: 'Create',
      repeat: 'Repeat',
      of: 'of',
      allFlashcards: 'All flashcards',
      login: 'Sign in',
      logout: 'Sign out',
      author: 'Pavel Pomerantsev',
      authorLink: 'http://facebook.com/pomerantsevp'
    },
    application: {
      index: {
        header: 'A simple way to memorize foreign words',
        subheader: 'Just like paper flashcards, but much more convenient.',
        loginForm: {
          header: 'Sign In',
          email: 'Email',
          password: 'Password',
          login: 'Sign in',
          signup: 'Become a member'
        }
      }
    },
    flashcards: {
      frontText: 'Word',
      backText: 'Meaning',
      new: {
        create: 'Create'
      },
      edit: {
        update: 'Save',
        delete: 'Delete'
      }
    },
    repetitions: {
      index: {
        dontRemember: 'I don’t remember',
        remember: 'I remember'
      }
    }
  });
