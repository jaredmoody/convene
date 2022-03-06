
class Space {
  constructor(spaceName) {
    this.name = spaceName;
    this.slug = spaceName.replace(/\s+/g, '-').toLowerCase();
  }

  asParams() {
    return {
      space: { name: this.name, slug: this.slug }
    }
  }
}

module.exports = Space;