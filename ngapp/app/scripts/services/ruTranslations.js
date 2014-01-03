'use strict';

angular.module('wordhubApp')
  .constant('RU_TRANSLATIONS', {
    flash: {
      userNotRegistered: 'Неверный логин / пароль.',
      networkError: 'Нет соединения с интернетом'
    },
    nav: {
      create: 'Создать',
      of: 'из',
      allFlashcards: 'Все карточки',
      logout: 'Выйти',
      author: 'Павел Померанцев',
      authorLink: 'http://pomerantsev.moikrug.ru'
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
