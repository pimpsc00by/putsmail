class Putsmail.Views.TestMailUsersEdit extends Backbone.View

  template: JST["test_mail_users/edit"]
  tagName: "tr"

  events:
    "click span.icon-remove-sign":     "destroy"
    "change input[name=mail_active]":  "activeDeactive"

  destroy: ->
    @model.destroy success: =>
      @$el.remove()

  activeDeactive:(event) ->
    @model.set active: $(event.target).is(":checked")
    @model.save()

  render: ->
    $(@el).html @template(model: @model)
    @
