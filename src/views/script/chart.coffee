API_KEY = 'AFArTyRIont4fZLaVXQVgY2kPv8EeIj4BwD24S3R'
endpoint = 'https://api.fda.gov/drug/event.json?api_key=' + API_KEY + '&'
dateFormat = d3.time.format('%Y%m%d')
csvData = []

capitalize = (s) ->
  return s.charAt(0).toUpperCase()+s.slice(1)

clickFirstDrug = ->
  document.getElementById('drugs').firstChild.firstChild.click()

getData = (callback) ->
  query = 'drug_counts.csv'
  d3.csv query, (error, data) ->
    if error 
      return alert(error)
    csvData = data
    csvData.forEach (d) ->
      d.dd = dateFormat.parse(d.date)
      return
    if callback != null
      callback()
      clickFirstDrug()
    return
  return

setupHeader = ->
  drugs = Object.keys csvData[0]
  parent = document.getElementById('drugs')
  drugs.forEach (d) ->
    if d == 'date' or d == 'dd' then return
    cap = capitalize(d)
    label = document.createElement("label")
    radio = document.createElement("input")
    radio.type = "radio"
    radio.name = "drugs"
    radio.value = cap
    radio.onclick = -> drawChart(d)
    label.appendChild(radio)
    label.appendChild(document.createTextNode(cap))
    parent.appendChild(label)
    return
  return

drawChart = (drug) ->
  ndx = crossfilter(csvData)
  xDimension = ndx.dimension((d) -> d.dd)
  yGroup = xDimension.group().reduceSum((d) -> d[drug])
  dc.lineChart('#chart')
  .width(1000)
  .height(500)
  .x(d3.time.scale().domain([new Date(1999, 0, 1),new Date(2015, 11, 31)]))
  .y(d3.scale.linear().domain([0, 10000]))
  .elasticY(true)
  .mouseZoomable(true)
  .renderHorizontalGridLines(true)
  .brushOn(false)
  .dimension(xDimension)
  .group(yGroup)
  .yAxisLabel(capitalize(drug) + " Count")
  .xAxisLabel("Date Received")
  dc.renderAll()
  return

getData(setupHeader)
