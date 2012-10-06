class Putsmail.Models.TestMail extends Backbone.Model
  urlRoot: "/api/test_mails"

  fetchByToken: (options) ->
    options ||= {}
    options["url"] = "/api/test_mails/#{@get("token")}"
    @fetch options