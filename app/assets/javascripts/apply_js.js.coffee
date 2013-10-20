$('html').removeClass('no-js').addClass('js')
###
Эта строка - чтобы не было мигающего выпадающего меню.
Элемент js-dropdown-menu ещё не появился,
но нужный стиль мы ему уже добавляем.
###
$('head').
	append('<style> #js-dropdown-menu { display: none; } </style>')
