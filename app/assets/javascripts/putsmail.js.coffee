window.Putsmail =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  init: -> 
    new Putsmail.Routers.TestMails
    Backbone.history.start(pushState: true)

$(document).ready ->
  Putsmail.init()

