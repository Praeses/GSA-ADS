API_KEY = 'AFArTyRIont4fZLaVXQVgY2kPv8EeIj4BwD24S3R'
endpoint = 'https://api.fda.gov/drug/event.json?api_key=' + API_KEY + '&'
dateFormat = d3.time.format('%Y%m%d')
csvData = []

capitalize = (s) ->
  return s.charAt(0).toUpperCase()+s.slice(1)

loadingDiv = (visible) ->
  [].forEach.call(document.getElementsByClassName("chart"), (v,i,a) ->
    if visible
      v.className += " whirl loadChart"
    else
      v.className = v.className.replace(" whirl loadChart","")
  )
  return

getData = (callback) ->
  loadingDiv(true)
  query = 'drug_counts.csv'
  d3.csv query, (error, data) ->
    if error 
      return alert(error)
    csvData = data
    csvData.forEach (d) ->
      d.dd = dateFormat.parse(d.date)
      return
    if callback
      callback()
    return
  return

getDrugList = (object) ->
  list = []
  keys = Object.keys object
  keys.forEach (k) ->
    if k == 'date' or k == 'dd' then return
    list.push k
    return
  return list

getRandomNumber = (max,min=0) ->
  return Math.floor(Math.random()*(max-min)+min)

getRandomColor = ->
  return d3.rgb(getRandomNumber(255),getRandomNumber(255),getRandomNumber(255)).toString()

getCharts = (chart, dim, list) ->
  group = []
  list.forEach (item) ->
    group.push dc.lineChart(chart).group(dim.group().reduceSum((d) -> d[item]), capitalize(item)).colors([getRandomColor()])
    return
  return group

drawChart = () ->
  chart = dc.compositeChart('#chart')
  ndx = crossfilter(csvData)
  dateDim = ndx.dimension((d) -> d.dd)

  chart
  .width(1000)
  .height(500)
  .margins({top:10,right:10,bottom:40,left:40})
  .x(d3.time.scale().domain([new Date(1999, 0, 1),new Date(2015, 11, 31)]))
  .y(d3.scale.linear().domain([0, 10000]))
  .elasticY(true)
  .mouseZoomable(true)
  .renderHorizontalGridLines(true)
  .legend(dc.legend().x(900).y(10))
  .brushOn(false)
  .dimension(dateDim)
  .yAxisLabel("Event Count")
  .xAxisLabel("Date Received")
  .compose(getCharts(chart,dateDim,getDrugList csvData[0]))

  dc.renderAll()
  loadingDiv(false)
  return

getData(drawChart)
