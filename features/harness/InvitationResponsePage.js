const Page = require("./Page");

class InvitationResponsePage extends Page {
  constructor(driver, invitation) {
    super(driver);
    this.invitation = invitation
  }

  url() {
    return this.invitation.rsvpLink()
  }

  submit() {
    return this.submitButton().click().then(() => this)
  }

  submitButton() {
    return this.component("input[type=submit")
  }
}

module.exports = InvitationResponsePage;
