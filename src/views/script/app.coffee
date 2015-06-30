
class Main
  constructor: () ->
    document.querySelector('.page-navigation').onclick = @closeMenu
    document.getElementById("menu-link").onclick = @toggleMenu
    elm.onclick = @toggleAge      for elm in document.getElementsByClassName("toggleAgeJs")
    elm.onclick = @toggleDrug     for elm in document.getElementsByClassName("toggleDrugJs")
    elm.onclick = @toggleLocation for elm in document.getElementsByClassName("toggleLocationJs")
    setTimeout @openCharts, 0

  toggleMenu: (e) ->
    e.cancelBubble = true
    el = document.querySelector('.page-container')
    el.classList.toggle('open');

  closeMenu: () =>
    if document.querySelector('.open')
      el = document.querySelector('.page-container')
      el.classList.toggle('open');


  isMoble: () ->
    document.body.offsetWidth < 768


  toggleAge: (e) =>
    @age_hidden = !@age_hidden
    @age_count.visable( @age_hidden )

  toggleDrug: (e) =>
    @drug_hidden = !@drug_hidden
    @drug_count.visable( @drug_hidden )

  toggleLocation: (e) =>
    @location_hidden = !@location_hidden
    @location_count.visable( @location_hidden )


  openCharts: () =>
    @drug_count = new App.DrugCountChart()
    setTimeout @drug_count.loadChart, 0
    @age_count = new App.AgeCountChart()
    setTimeout @age_count.loadChart, 0
    @location_count = new App.LocationCountChart()
    setTimeout @location_count.loadChart, 0
    height = 200 if @isMoble()
    @drugs = new App.DrugChart({height: height})
    setTimeout @drugs.loadChart, 0







global_namespace = global if global?
global_namespace = window if window?
global_namespace.App = {} unless global_namespace.App
global_namespace.App.app = new Main()

