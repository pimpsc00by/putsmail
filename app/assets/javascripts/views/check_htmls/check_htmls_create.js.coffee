class Putsmail.Views.CheckHtmlsCreate extends Backbone.View

  template: JST['check_htmls/create']

  render: ->
    $(@el).html(@template(model: @model))
    this