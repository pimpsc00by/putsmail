class Putsmail.Views.TestMailUsersIndex extends Backbone.View

  template: JST['test_mail_users/index']

  initialize: ->
    @collection.on('reset', @render, this)
    @collection.on("add", @addTestMailUser, this)

  addTestMailUser:(model) ->
    testMailUserView = new Putsmail.Views.TestMailUsersEdit(model: model)
    $("#container_test_mail_user").prepend(testMailUserView.render().el)

  render: ->
    $(@el).html(@template(collection: @collection))
    @collection.each(@addTestMailUser)
    this
