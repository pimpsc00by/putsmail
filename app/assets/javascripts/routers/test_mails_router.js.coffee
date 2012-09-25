class Putsmail.Routers.TestMails extends Backbone.Router

  routes:
    "": "index"
    "tests/:token" : "show"

  index: ->
    if lastId = $("#test_mail_form_container").data "id"
      Backbone.history.navigate "/tests/#{lastId}", true
    else
      model = new Putsmail.Models.TestMail
      model.save {}
        success:(model, response) ->
          Backbone.history.navigate "/tests/#{model.get("token")}", true

  show: (token) ->
    model = new Putsmail.Models.TestMail(token: token)
    model.fetchByToken
      success: ->
        view = new Putsmail.Views.TestMailsIndex model: model
        $("#test_mail_form_container").html view.render().el
        view.trigger "rendered"

