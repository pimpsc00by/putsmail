class Putsmail.Views.TestMailsIndex extends Backbone.View

  template: JST['test_mails/index']

  events:
    "submit #form_test_email": "sendTest"

  render: ->
    $(@el).html(@template)
    this

  sendTest: (event) ->
    event.preventDefault()
    recipients = _.map $("input[name=test_mail_recipients]"), 
       (recipient) -> $(recipient).val()
    testMail = new Putsmail.Models.TestMail
    testMail.save {test_mail: 
         body: $("#test_mail_body").val()
         subject: $("#test_mail_subject").val()
         recipients: recipients}
      wait: true
      success:(model, response) -> alert "saved"
      error: @handleError

  handleError: (model, response) ->
    if response.status == 422
      errors = $.parseJSON(response.responseText)
      for attribute, messages of errors
        alert "#{attribute} #{message}" for message in messages