# @todo Maybe we want to try?
# http://jsonapi-rb.org/guides/serialization/defining.html
class Space::Serializer
  # @return [Space]
  attr_accessor :space

  def initialize(space)
    @space = space
  end

  # @todo make this even more like JSON API?
  #       https://jsonapi.org/format/1.1/#fetching-resources-responses
  def to_json
    {
      errors: space.errors.map(&method(:error_json)),
      space: {
        id: space.id,
        slug: space.slug,
        name: space.name,
      }
    }
  end

  private def error_json(error)
    {
      code: error.type,
      title: error.full_message,
      detail: error.message,
      source: {
        pointer: "/#{error.base.model_name.param_key}/#{error.attribute}"
      }
    }
  end
end