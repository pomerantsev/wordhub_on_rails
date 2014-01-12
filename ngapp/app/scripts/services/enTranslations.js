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
      index: {
        search: 'Search',
        filtered: 'Filtered by',
        showAll: 'show all',
        showDeleted: 'Show deleted flashcards ({{count}}) — will be removed completely tomorrow',
        justDeleted: 'Deleted today',
        undelete: 'Восстановить'
      },
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
    },
    users: {
      email: 'Email',
      password: 'Password',
      name: 'Name',
      dailyLimit: 'Daily limit',
      new: {
        newUser: 'New user',
        notGoingToShare: 'We will not share it with anyone, we promise.',
        anyCombination: 'Any digit and letter combination no less than six symbols will do. Case (upper or lower) matters.',
        howToAddress: 'Here you can specify how you wish to be addressed. 25 symbols max.',
        signUp: 'Sign up'
      }
    }
  });
