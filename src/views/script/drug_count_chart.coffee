dateFormat = d3.time.format('%Y%m%d')

class DrugCountChart

  constructor: (@args = {}) ->
    @args.el = "drugCountChart" unless @args.el
    @args.el = document.getElementById(@args.el)
    @chart = dc.pieChart("#" + @args.el.id)
    @args.url= "/drug_counts.csv"
    @width = @args.el.parentNode.offsetWidth - 50


  loadingDiv: (visible) =>
    if visible
      @args.el.className += " whirl loadChart"
    else
      @args.el.className = @args.el.className.replace(" whirl loadChart","")
    visible


  loadChart: () =>
    @loadingDiv(true)
    setTimeout @getData, 0


  getData: () =>
    d3.csv @args.url, @onData


  onData: (error, data) =>
    @ndx = crossfilter(data)
    @drawChart()

  drawChart: () =>
    dim = @ndx.dimension( (d) -> d["DRUG"] )
    group = dim.group().reduceSum( (d) -> d[" COUNT"] )
    @chart
      .width(@width)
      .dimension(dim)
      .group(group)
      .slicesCap(8)
      .render()
    @loadingDiv(false)




global_namespace = global if global?
global_namespace = window if window?
global_namespace.App = {} unless global_namespace.App
global_namespace.App.DrugCountChart = DrugCountChart

