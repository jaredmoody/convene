const { defineParameterType } = require("@cucumber/cucumber");
const Invitation = require('../../lib/Invitation.js')

defineParameterType({
  name: "invitation",
  regexp: /Invitation( to "[^"]*")?/,
  transformer: function(a, b, c) {
    const emailAddress = a ? a.match(/to "([^"]*)"/)[1] : undefined
    return new Invitation(emailAddress)
  }
});