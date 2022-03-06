const axios = require("axios");
const applyCaseMiddleware = require("axios-case-converter").default;
const Space = require("./Space");
const AuthenticationMethod = require("./AuthenticationMethod");
class Api {
  constructor(host, apiKey) {
    this.host = host;
    this.apiKey = apiKey;
    this.axios = applyCaseMiddleware(
      axios.create({
        baseURL: host,
      })
    );

    // Alter defaults after instance has been created
    this.axios.defaults.headers.common[
      "Authorization"
    ] = `Token token="${apiKey}"`;
    this.axios.defaults.headers.common["Content-Type"] = "application/json";
    this.axios.defaults.headers.common["Accept"] = "application/json";
  }

  /**
   * @returns {Repository}
   */
  spaces() {
    return new Repository({ client: this, endpoint: "/spaces" });
  }

  /**
   * @returns {Repository}
   */
  authenticationMethods() {
    return new Repository({
      client: this,
      endpoint: "/authentication_methods",
    });
  }

  post(path, model) {
    return this.axios.post(path, model.asParams()).catch(function (error) {
      console.error(`Can't POST to ${path}`);
      console.error(model.asParams());
      throw error;
    });
  }
}
exports.Api = Api;
class Repository {
  constructor({ client, endpoint }) {
    this.client = client;
    this.endpoint = endpoint;
  }

  create(model) {
    return this.client.post(this.endpoint, model);
  }

  findOrCreateBy(model) {
    return this.create(model);
  }
}
