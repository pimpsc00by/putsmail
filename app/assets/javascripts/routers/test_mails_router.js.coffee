class Putsmail.Routers.TestMails extends Backbone.Router

  routes:
    "": "index"

  index: ->
    view = new Putsmail.Views.TestMailsIndex
    $("#test_mail_form_container").html(view.render().el)