dateFormat = d3.time.format('%Y%m%d')

class AgeCountChart

  constructor: (@args = {}) ->
    @args.el = "ageCountChart" unless @args.el
    @args.el = document.getElementById(@args.el)
    @chart = dc.barChart("#" + @args.el.id)
    @args.url= "/age_counts.csv"
    @width = @args.el.parentNode.offsetWidth


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
    dim = @ndx.dimension( (d) -> d["AGE"] )
    group = dim.group().reduceSum( (d) -> d[" COUNT"] )
    @chart
      .width(@width)
      .dimension(dim)
      .group(group)
      .margins({top:10,right:20,bottom:30,left:50})
      .x(d3.scale.linear().domain([0, 100]))
      .render()
    @loadingDiv(false)




global_namespace = global if global?
global_namespace = window if window?
global_namespace.App = {} unless global_namespace.App
global_namespace.App.AgeCountChart = AgeCountChart

