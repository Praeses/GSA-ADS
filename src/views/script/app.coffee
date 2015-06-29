
class Main
  constructor: () ->
    document.querySelector('.page-navigation').onclick = @closeMenu
    document.getElementById("menu-link").onclick = @toggleMenu
    setTimeout @openCharts, 0
    #setTimeout App.app.openCharts, 0

  toggleMenu: (e) ->
    e.cancelBubble = true
    el = document.querySelector('.page-container')
    el.classList.toggle('open');

  isMoble: () ->
    document.body.offsetWidth < 768


  closeMenu: () =>
    if document.querySelector('.open')
      el = document.querySelector('.page-container')
      el.classList.toggle('open');

  openCharts: () =>
    drug_count = new App.DrugCountChart()
    setTimeout drug_count.loadChart, 0

    age_count = new App.AgeCountChart()
    setTimeout age_count.loadChart, 0

    location_count = new App.LocationCountChart()
    setTimeout location_count.loadChart, 0

    height = 200 if @isMoble()
    drugs = new App.DrugChart({height: height})
    setTimeout drugs.loadChart, 0







global_namespace = global if global?
global_namespace = window if window?
global_namespace.App = {} unless global_namespace.App
global_namespace.App.app = new Main()

