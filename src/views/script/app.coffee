
class App
  constructor: () ->
    document.querySelector('.page-navigation').onclick = @closeMenu
    document.getElementById("menu-link").onclick = @toggleMenu

  toggleMenu: (e) ->
    e.cancelBubble = true
    el = document.querySelector('.page-container')
    el.classList.toggle('open');

  closeMenu: () ->
    if document.querySelector('.open')
      el = document.querySelector('.page-container')
      el.classList.toggle('open');











window.app = new App()
