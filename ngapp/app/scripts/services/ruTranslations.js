'use strict';

angular.module('wordhubApp')
  .constant('RU_TRANSLATIONS', {
    flash: {
      userNotRegistered: 'Неверный логин / пароль.',
      unauthorized: 'Вы не авторизованы. Пожалуйста, войдите на сайт.'
    },
    nav: {
      wordhub: 'Вордхаб',
      create: 'Создать',
      repeat: 'Повторить',
      of: 'из',
      allFlashcards: 'Все карточки',
      login: 'Вход',
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
    },
    flashcards: {
      frontText: 'Слово',
      backText: 'Значение',
      index: {
        search: 'Найти',
        filtered: 'Отфильтровано по',
        showAll: 'показать все'
      },
      new: {
        create: 'Создать'
      },
      edit: {
        update: 'Сохранить',
        delete: 'Удалить'
      }
    },
    repetitions: {
      index: {
        dontRemember: 'Не помню',
        remember: 'Помню'
      }
    }
  });
