app =
  initialize: ->
    alert "test"
    document.getElementById("menu-link").onclick = @toggleMenu

  toggleMenu: (e) =>






app.initialize()
