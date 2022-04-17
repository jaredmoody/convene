# frozen_string_literal: true

class AuthenticationMethod::Serializer < ApplicationSerializer
  # @return [AuthenticatioMethod]
  alias authentication_method resource

  def to_json(*_args)
    super.merge({
                  authentication_method: {
                    id: authentication_method.id,
                    contact_method: authentication_method.contact_method,
                    contact_location: authentication_method.contact_location,
                    person: {
                      id: authentication_method.person.id
                    }
                  }
                })
  end
end
