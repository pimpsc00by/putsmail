class Putsmail.Views.TestMailsIndex extends Backbone.View

  template: JST['test_mails/index']

  events:
    "submit #form_test_email": "sendTest"
    "click #add_cc": "showCC"
    "focus .test_mail_cc input[name='test_mail_recipients']": "makeVisible"
    "blur  .test_mail_cc input[name='test_mail_recipients']": "checkFilled"
    

  render: ->
    $(@el).html(@template)
    this

  showCC: (event) ->
    event.preventDefault()
    $(".test_mail_cc").show 500, ->
      firstCc = $(".test_mail_cc input[name='test_mail_recipients']").first()
      firstCc.focus()
      firstCc.css("opacity", 1)

  makeVisible: (event) ->
    obj = $(event.target)
    obj.parent().parent().css("opacity", 1)

  checkFilled: (event) ->
    obj = $(event.target)
    if not _.isEmpty obj.val()
      obj.parent().parent().css("opacity", 1)
    else
      obj.parent().parent().css("opacity", .5)

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
      msg = ""
      for attribute, messages of errors
        msg += " #{attribute} #{message} \n" for message in messages
      unless _.isEmpty msg
        msg = "There were problems with the following fields:\n\n" + msg
        alert msg