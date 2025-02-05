# frozen_string_literal: true
class PaymentForm
  class PaymentPolicy
    attr_accessor :object, :actor

    def initialize(actor, object)
      self.object = object
      self.actor = actor
    end

    def show?
      actor.member_of?(object.space)
    end

    alias update? show?
    alias edit? show?
    alias destroy? show?

    def index?
      # The Scope resolution limits access to Payments from Spaces
      # this Actor belongs to.
      true
    end

    def create?
      true
    end

    def permitted_attributes
      %i[payer_name payer_email amount memo public_token plaid_account_id account_description]
    end

    class Scope
      attr_accessor :actor, :scope

      def initialize(actor, scope)
        self.actor = actor
        self.scope = scope
      end

      def resolve
        scope.where(space: actor.spaces)
      end
    end
  end
end
