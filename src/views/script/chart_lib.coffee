
ChartLib = {}


ChartLib.capitalize = (s) ->
  s.charAt(0).toUpperCase()+s.slice(1)

ChartLib.getRandom = (max,min=0) =>
  return Math.floor(Math.random()*(max-min)+min)

ChartLib.findKeys = (object, ignore) =>
	list = []
	keys = Object.keys object
	keys.forEach (k) ->
	  if ignore.indexOf(k) > -1
	    return
	  list.push k
	  return
	return list

exp = global if global?
exp = window if window?
exp.App = {} unless exp.App
exp.App.ChartLib = ChartLib

