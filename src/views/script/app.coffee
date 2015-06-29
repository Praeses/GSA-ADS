
class Main
  constructor: () ->
    document.querySelector('.page-navigation').onclick = @closeMenu
    document.getElementById("menu-link").onclick = @toggleMenu
    @openCharts()

  toggleMenu: (e) ->
    e.cancelBubble = true
    el = document.querySelector('.page-container')
    el.classList.toggle('open');

  closeMenu: () ->
    if document.querySelector('.open')
      el = document.querySelector('.page-container')
      el.classList.toggle('open');

  openCharts: () ->
    drug_count = new App.DrugCountChart()
    setTimeout drug_count.loadChart, 0

    drugs = new App.DrugChart()
    setTimeout drugs.loadChart, 0









global_namespace = global if global?
global_namespace = window if window?
global_namespace.App = {} unless global_namespace.App
global_namespace.App.app = new Main()

