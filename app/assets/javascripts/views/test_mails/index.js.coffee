class Putsmail.Views.TestMailsIndex extends Backbone.View

  template: JST["test_mails/index"]

  events:
    "click #button_send":                 "sendTest"
    "click #button_check_mail":           "checkMail"
    "click #test_email_in_gallery":       "saveGalleryPreferences"
    "click #test_email_make_css_inline":  "saveCSSPreferences"
    "click #button_add_recipient":        "newRecipient"
    "click #new_window_preview":          "newWindowPreview"
    "change #body_preview_resolution":    "changeResolution"

  initialize: ->
    @bind "rendered", @afterRender, this
    @testMailUsersCollection = new Putsmail.Collections.TestMailUsers()
    @testMailUsersView       = new Putsmail.Views.TestMailUsersIndex collection: @testMailUsersCollection
    @testMailUsersCollection.fetch()

  changeResolution: (event) ->
    resolution = $(event.target).val()
    $("#body_preview").attr "class", resolution

  newRecipient: (event) ->
    event.preventDefault()

    @testMailUsersCollection.create test_mail_id: @model.id, mail: $("#test_mail_users0").val(), active: true,
      wait: true
      success: ->
        $("#test_mail_users0").val ""
        $("#test_mail_users0").focus()
      error: ->
        $("#test_mail_users0").val ""
        $("#test_mail_users0").focus()

  afterRender: ->
    @editor = CodeMirror.fromTextArea document.getElementById("test_mail_body"),
      mode: "text/html", tabMode: "indent", theme: "myeclipse", onChange: @updatePreview, height: 150

    if @model.get "body"
      @editor.setValue @model.get("body")
    if @model.get "subject"
      $("#test_mail_subject").val @model.get("subject")

    @updatePreview()
    window.xxx = @model
    $("#test_email_in_gallery").attr "checked", @model.get("in_gallery")
    $("#test_email_make_css_inline").attr "checked", @model.get("make_css_inline")
    $("#recipients_container").html @testMailUsersView.render().el

  render: ->
    $(@el).html @template(model: @model)
    @

  newWindowPreview: (event) ->
    event.preventDefault()
    preview = window.open "", "puts_mail_preview"
    preview.document.write @editor.getValue()
    preview.focus()

  updatePreview: =>
    ifrm = document.getElementById("body_preview")
    if ifrm.contentWindow
      ifrmDocument = ifrm.contentWindow.document
    else
      ifrmDocument = ifrm.contentDocument
    ifrmDocument.open()
    ifrmDocument.write @editor.getValue()
    ifrmDocument.close()

  checkMail: (event) ->
    event.preventDefault()

    @showNoty "Checking..."

    check = new Putsmail.Models.CheckHtml
    check.save test_mail: body: @editor.getValue(),
      wait: true
      success:(model, response) =>
        if $("#test_email_make_css_inline").is(":checked")
           @editor.setValue model.get("body")

        checkHtmlView = new Putsmail.Views.CheckHtmlsCreate model: model

        $("#html_warnings").html(checkHtmlView.render().el)

        $.noty.close()
      error: (model, response) ->
        $.noty.close()

  sendTest: (event) ->
    event.preventDefault()

    recipients = _.map $("input[name=test_mail_users_mail]:visible"),
       (recipient) ->  mail: $(recipient).val()

    @saveEmail "Sending...",
      dispatch: true, body: @editor.getValue(), subject: $("#test_mail_subject").val(), users: recipients

  saveCSSPreferences: (event) ->
    @saveEmail "Updating Preferences...",
      make_css_inline: $(event.target).is(":checked")

  saveGalleryPreferences: (event) ->
    @saveEmail "Updating Preferences...",
      in_gallery: $(event.target).is(":checked")

  saveEmail: (message, data) ->
    @clearPreviousErrors()

    @showNoty message

    @model.save data,
      wait: true
      success: (model, response) ->
        $.noty.close()
      error: (model, response) =>
        $.noty.close()
        @handleError model, response

  clearPreviousErrors: ->
    $("span.error_message").remove()
    $("div.error").removeClass "error"

  handleError: (model, response) ->
    if response.status == 422
      errors = $.parseJSON(response.responseText)
      for attribute, messages of errors
        for message in messages
          input = $("input[name=#{attribute}], textarea[name=#{attribute}], input[id=#{attribute}]")
          if input.length > 0
            input.parent().parent().addClass "error"
            input.after "<span class=\"help-inline error_message\">#{message}</span>"

  showNoty: (message) ->
    $.noty text: message, speed: 100, closeable: true, type: "alert", layout: "topRight", timeout: false, theme: "mitgux"

