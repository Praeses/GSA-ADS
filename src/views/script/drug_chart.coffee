dateFormat = d3.time.format('%Y%m%d')

class DrugChart

  constructor: (@args = {}) ->
    @args.height = @args.height || 500
    @loading = false
    @loadingDiv(true)
    @compositeChart = dc.compositeChart('#compositeChart')
    @args.url= "/drug_events_by_date.csv"
    @width = document.getElementById("compositeChart").parentNode.offsetWidth
    @wireUpEvents()


  wireUpEvents: () =>
    for elm in document.getElementsByName("drugResolution")
      elm.nextElementSibling.onclick = @onResolutionChanged


  loadingDiv: (visible) =>
    element = document.getElementById("compositeChart")
    if visible
      element.className += " whirl loadChart"
    else
      element.className = element.className.replace(" whirl loadChart","")
    return


  getRandomColor: =>
    return d3.rgb(App.ChartLib.getRandom(255),App.ChartLib.getRandom(255),App.ChartLib.getRandom(255)).toString()


  getDrugList: (object) =>
    list = []
    keys = Object.keys object
    keys.forEach (k) ->
      if k == 'date' or k == 'dd' or k == 'dm' or k == 'dy' then return
      list.push k
      return
    return list


  loadChart: () =>
    @getData(@args.url)


  getData: (url) =>
    d3.csv url, @onData


  onData: (error, data) =>
    @min_date = dateFormat.parse(data[0].date)
    @max_date = dateFormat.parse(data[data.length - 1].date)
    data.forEach (d) ->
      d.dd = dateFormat.parse(d.date)
      d.dm = dateFormat.parse(d.date).setDate(1)
      d.dy = dateFormat.parse(d.date).setMonth(1,1)
    @ndx = crossfilter(data)
    @drugList = App.ChartLib.findKeys data[0],['date','dd','dm','dy']
    @drawChart()


  getDimension: (resolution) =>
    if resolution == 1
      return @ndx.dimension((d) -> d.dd)
    else if resolution == 2
      return @ndx.dimension((d) -> d.dm)
    else if resolution == 3
      return @ndx.dimension((d) -> d.dy)
    else
      return @ndx.dimension((d) -> d.dm)


  getCharts: (dimension) =>
    group = []
    @drugList.forEach (item) =>
      group.push(dc.lineChart(@compositeChart)
        .group(@getGroup(dimension, item), App.ChartLib.capitalize(item))
        .colors([@getRandomColor()])
        .title((d) => App.ChartLib.getTime(d.x)+' - '+d.y))
      return
    return group


  getGroup: (dimension, item) =>
    dimension.group().reduceSum((d) => d[item])


  drawChart: (resolution) =>
    dimension = @getDimension(resolution)
    @compositeChart
      .width(@width)
      .height(@args.height)
      .margins({top:10,right:10,bottom:30,left:50})
      .x(d3.time.scale().domain([@min_date,@max_date]))
      .y(d3.scale.linear().domain([0, 10000]))
      .elasticY(true)
      .legend(dc.legend().x(80).y(10))
      .renderHorizontalGridLines(true)
      .brushOn(false)
      .dimension(dimension)
      .yAxisLabel("Event Count")
      .xAxisLabel("Date Received")
      .compose(@getCharts(dimension))
      .render()
    @loadingDiv(false)
    setTimeout (=> 
      @loadingDiv(false)
      @loading = false), 50


  onResolutionChanged: (e) =>
    return false if @loading
    @loading = true
    @loadingDiv(true)
    id = e.target.previousElementSibling.id
    resolution = 2
    resolution = 1 if id == "btnDay"
    resolution = 2 if id == "btnMonth"
    resolution = 3 if id == "btnYear"
    setTimeout (=> @drawChart resolution), 1







global_namespace = global if global?
global_namespace = window if window?
global_namespace.App = {} unless global_namespace.App
global_namespace.App.DrugChart = DrugChart


