class Putsmail.Views.TestMailUsersEdit extends Backbone.View

  template: JST['test_mail_users/edit']
  tagName: "tr"

  events:
    "click span.icon-remove-sign": "destroy"
    "change input[name=mail_active]": "activeDeactive"

  destroy: ->
    thiz = this
    @model.destroy success: ->
      thiz.$el.remove()

  activeDeactive:(event) ->
    obj = $(event.target)
    @model.set({active: obj.is(":checked")})
    @model.save()

  render: ->
    $(@el).html(@template(model: @model))
    this