class Putsmail.Routers.TestMails extends Backbone.Router

  routes:
    "": "index"

  index: ->
    view = new Putsmail.Views.TestMailsIndex()
    $("div.container").html(view.render().el)
