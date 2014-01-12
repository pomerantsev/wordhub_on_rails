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
      stats: 'Статистика',
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
        showAll: 'показать все',
        showDeleted: 'Показать удалённые карточки ({{count}}) — завтра будут совсем удалены',
        justDeleted: 'Удалённые сегодня',
        undelete: 'Восстановить'
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
    },
    users: {
      email: 'Email',
      password: 'Пароль',
      name: 'Имя',
      dailyLimit: 'Дневной лимит',
      errors: {
        email: {
          required: 'Пожалуйста, введите email.',
          email: 'Email неверного формата. Пожалуйста, проверьте.',
          maxlength: 'Email слишком длинный.'
        },
        password: {
          required: 'Пожалуйста, введите пароль.',
          minlength: 'Пароль слишком короткий.',
          maxlength: 'Пароль слишком длинный.'
        },
        name: {
          maxlength: 'Имя слишком длинное.'
        }
      },
      new: {
        newUser: 'Регистрация',
        notGoingToShare: 'Мы ни с кем не будем делиться вашим адресом.',
        anyCombination: 'Любая комбинация цифр (0-9) и латинских букв (a-z, A-Z) без пробелов, не короче 6 символов. РеГисТР имеет значение.',
        howToAddress: 'Можете указать, как к вам обращаться (не длиннее 25 символов).',
        signUp: 'Зарегистрироваться'
      }
    }
  });
