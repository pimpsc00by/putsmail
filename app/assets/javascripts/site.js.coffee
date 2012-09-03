# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  $("#btn_back_to_top").click (event) -> 
    event.preventDefault()
    $.smoothScroll(speed: 500)
  $("#btn_new_test_mail").click (event) ->
    event.preventDefault()
    $("#test_mail_form_container").data("id", "")
    Backbone.history.navigate("/", true)
