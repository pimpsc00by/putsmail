class Putsmail.Views.TestMailsIndex extends Backbone.View

  template: JST['test_mails/index']

  events:
    "submit #form_test_email": "sendTest"
    "click #button_preview": "preview"
    "click #button_check_mail": "checkMail"
    "click #btnAddRecipient": "newRecipient"

  initialize: ->
    this.bind('rendered', this.afterRender, this);
    this.testMailUsersCollection = new Putsmail.Collections.TestMailUsers()
    this.testMailUsersView = new Putsmail.Views.TestMailUsersIndex(collection: this.testMailUsersCollection)
    this.testMailUsersCollection.fetch()

  newRecipient: (event) ->
    event.preventDefault() 
    this.testMailUsersCollection.create {test_mail_id: this.model.id, mail: $("#test_mail_users0").val(), active: true},
      wait: true
      success: -> 
        $('#test_mail_users0').val("")
        $('#test_mail_users0').focus()
      error: ->
        $('#test_mail_users0').val("")
        $('#test_mail_users0').focus()

  afterRender: ->
    this.editor = CodeMirror.fromTextArea document.getElementById("test_mail_body"), 
      {mode: "text/html", tabMode: "indent", theme: "myeclipse", onChange: this.updatePreview, height: 150}
    if this.model.get("body")
      this.editor.setValue(this.model.get("body"))
    if this.model.get("subject")
      $("#test_mail_subject").val(this.model.get("subject"))
    this.updatePreview()
    $("#recipients_container").html(this.testMailUsersView.render().el)

  render: ->
    $(@el).html(@template(model: @model))
    this

  updatePreview: =>
    ifrm = document.getElementById('body_preview')
    if ifrm.contentWindow
      ifrmDocument = ifrm.contentWindow.document
    else 
      ifrmDocument = ifrm.contentDocument
    ifrmDocument.open()
    ifrmDocument.write(@editor.getValue())
    ifrmDocument.close()

  checkMail: ->
    event.preventDefault()
    thiz = @
    $.noty({text: 'Checking...', speed: 100, closeable: true, type: "alert", layout: "topRight", timeout: false, theme: "mitgux"})
    check = new Putsmail.Models.CheckHtml
    check.save {test_mail: 
         body: thiz.editor.getValue()}
      wait: true
      success:(model, response) ->
        thiz.editor.setValue(model.get("body"))
        checkHtmlView = new Putsmail.Views.CheckHtmlsCreate(model: model)
        $("#html_warnings").html(checkHtmlView.render().el)
        $.noty.close()
      error: (model, response) ->
        $.noty.close()

  preview: ->
    event.preventDefault()
    preview = window.open ""
    preview.document.write @editor.getValue()
      

  sendTest: (event) ->
    event.preventDefault()
    @clearPreviousErrors()
    thiz = this
    $.noty({text: 'Sending...', speed: 100, closeable: true, type: "alert", layout: "topRight", timeout: false, theme: "mitgux"})
    recipients = _.map $("input[name=test_mail_users_mail]:visible"), 
       (recipient) -> {mail: $(recipient).val()}
    thiz.model.save {
         body: @editor.getValue()
         subject: $("#test_mail_subject").val()
         users: recipients}
      wait: true
      success:(model, response) -> 
        $.noty.close()
      error: (model, response) -> 
        $.noty.close()
        thiz.handleError(model, response)

  clearPreviousErrors: ->
    $("span.error_message").remove()
    $("div.error").removeClass("error")

  handleError: (model, response) ->
    if response.status == 422
      errors = $.parseJSON(response.responseText)
      for attribute, messages of errors
        for message in messages
          input = $("input[name=#{attribute}], textarea[name=#{attribute}], input[id=#{attribute}]")
          if input.length > 0
            input.parent().parent().addClass("error")
            input.after("<span class=\"help-inline error_message\">#{message}</span>")
