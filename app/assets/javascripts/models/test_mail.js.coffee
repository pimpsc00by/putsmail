class Putsmail.Models.TestMail extends Backbone.Model
  urlRoot: "/api/test_mails"

  fetchByToken: (options) ->
    options ||= {}
    options["url"] = "/api/test_mails/#{this.get("token")}"
    this.fetch options