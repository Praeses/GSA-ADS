API_KEY = 'AFArTyRIont4fZLaVXQVgY2kPv8EeIj4BwD24S3R'
endpoint = 'https://api.fda.gov/drug/event.json?api_key=' + API_KEY + '&'
dateFormat = d3.time.format('%Y%m%d')
dates = []


getDateCounts = ->
  query = 'drug_counts.csv'
  d3.csv query, (error, data) ->
    if error 
      return alert(error)
    dates = data
    dates.forEach (d) ->
      d.dd = dateFormat.parse(d.date)
      return
    alert JSON.stringify(dates)
    drawChart()
    return
  return

drawChart = ->
  ndx = crossfilter(dates)
  xDimension = ndx.dimension((d) ->
    d.dd
  )
  yGroup = xDimension.group().reduceSum((d) -> 
  	d.sodium
  )
  dc.lineChart('#chart')
  .width(1000)
  .height(500)
  .x(d3.time.scale().domain([new Date(1995, 0, 1),new Date(2016, 11, 31)]))
  .y(d3.scale.linear().domain([0, 10000]))
  .elasticY(true)
  .mouseZoomable(true)
  .renderHorizontalGridLines(true)
  .renderArea(true)
  .dimension(xDimension)
  .group(yGroup)
  .yAxisLabel("Event Count")
  .xAxisLabel("Date Received")
  
  dc.renderAll()
  return

getDateCounts()
