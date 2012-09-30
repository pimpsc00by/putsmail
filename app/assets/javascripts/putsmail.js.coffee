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
      $("#btn_new_test_mail").click (event) ->
        event.preventDefault()
        $("#test_mail_form_container").data "id", ""
        Backbone.history.navigate "/", true

      Putsmail.init()
