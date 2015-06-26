
ChartLib = {}


ChartLib.capitalize = (s) ->
  s.charAt(0).toUpperCase()+s.slice(1)


exp = global || window
exp.App = {} unless exp.App
exp.App.ChartLib = ChartLib

