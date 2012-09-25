App.site ||= {}

window.Putsmail =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  init: -> 
    new Putsmail.Routers.TestMails
    Backbone.history.start pushState: true

App.site["index"] = ->
    $ ->
      Putsmail.init()
