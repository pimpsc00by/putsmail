class Putsmail.Views.TestMailUsersIndex extends Backbone.View

  template: JST['test_mail_users/index']

  render: ->
    $(@el).html(@template(collection: @collection))
    this