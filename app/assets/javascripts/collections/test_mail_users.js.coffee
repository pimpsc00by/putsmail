class Putsmail.Collections.TestMailUsers extends Backbone.Collection
  url: "/api/test_mail_users"

  model: Putsmail.Models.TestMailUser

  fetchByTestMail: (test_mail_id) ->
    options = {}
    options["url"] = "/api/test_mail_users?test_mail_id=#{test_mail_id}"
    this.fetch options
