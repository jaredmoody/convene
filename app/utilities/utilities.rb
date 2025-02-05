# frozen_string_literal: true

# {Utilities} allow external services to provide functionality to a {Space} and
# its {Furniture}.
#
# Every {Space} can have {UtilityHookup}s that securely store API keys and other
# configuration for the {Utility} to work with the {Space}.
#
# @see features/utilities.feature
# @see features/utilities/
module Utilities
  REGISTRY = {
    plaid: Plaid::PlaidUtility,
    jitsi: Jitsi::JitsiUtility
  }.freeze

  # @param utility_hookup [UtilityHookup]
  # @return [Utility]
  def self.from_utility_hookup(utility_hookup)
    new_from_slug(utility_hookup.utility_slug, utility_hookup: utility_hookup)
  end

  def self.new_from_slug(slug, attributes = {})
    REGISTRY.fetch(slug.to_sym, NullUtility).new(attributes)
  end
end
