'use strict';

angular.module('wordhubApp')
  .constant('RU_TRANSLATIONS', {
    flash: {
      userNotRegistered: 'Неверный логин / пароль.'
    },
    nav: {
      create: 'Создать',
      of: 'из',
      allFlashcards: 'Все карточки',
      logout: 'Выйти'
    },
    application: {
      index: {
        header: 'Простой способ учить иностранные слова',
        subheader: 'Как бумажные карточки, только удобнее.',
        loginForm: {
          header: 'Вход на сайт',
          email: 'Email',
          password: 'Пароль',
          login: 'Войти',
          signup: 'Зарегистрироваться'
        }
      }
    }
  });
