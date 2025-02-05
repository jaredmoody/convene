# frozen_string_literal: true

class PaymentForm
  class PaymentsController < FurnitureController
    def create
      return if payment.save

      render :new
    end

    def index; end

    private def payment_params
      params.require(:payment_form_payment)
            .permit(policy(payments.new).permitted_attributes)
    end

    # @returns [PaymentForm]
    helper_method def furniture
      room.furniture_placements.find_by(furniture_kind: 'payment_form').furniture
    end

    helper_method def room
      current_space.rooms.friendly.find(params[:room_id])
    end

    helper_method def space
      current_space
    end

    helper_method def payment
      @payment ||= payments.new(payment_params)
    end

    helper_method def payments
      @payments ||= policy_scope(furniture.payments).tap do |payments|
        authorize(payments)
      end
    end
  end
end
