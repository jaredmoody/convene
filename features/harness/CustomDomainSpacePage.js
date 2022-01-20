import SpacePage from './SpacePage.js';

export class CustomDomainSpacePage extends SpacePage {
  constructor(driver, customDomain) {
    this.customDomain = customDomain;
    super(driver);
  }

  enter() {
    this.driver.get(`${this.customDomain}`);
  }

  enterRoomThruUrl(room) {
    this.driver.get(`${this.customDomain}/${room.slug}`);
  }
}
