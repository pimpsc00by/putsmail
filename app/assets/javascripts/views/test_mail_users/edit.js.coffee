class Putsmail.Views.TestMailUsersEdit extends Backbone.View

  template: JST['test_mail_users/edit']
  tagName: "tr"

  render: ->
    $(@el).html(@template(model: @model))
    this