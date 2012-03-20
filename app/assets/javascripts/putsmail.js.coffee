window.Putsmail =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  init: -> 
    new Putsmail.Routers.TestMails
    Backbone.history.start()

$(document).ready ->
  Putsmail.init()
