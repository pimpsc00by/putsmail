class Putsmail.Routers.TestMails extends Backbone.Router

  routes:
    "": "index"

  index: ->
    model = new Putsmail.Models.TestMail
    model.set({recipients: $.parseJSON($("#last_recipients").html())})
    view = new Putsmail.Views.TestMailsIndex model: model
    $("#test_mail_form_container").html(view.render().el)