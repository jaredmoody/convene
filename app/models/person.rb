# frozen_string_literal: true

# A representation of a human
class Person < ApplicationRecord
  validates :email, presence: true, uniqueness: { case_sensitive: false }

  # Joins the person to the spaces they are part of
  has_many :space_memberships, inverse_of: :member, foreign_key: :member_id, dependent: :destroy_async

  # Ways for the person to sign in
  has_many :authentication_methods, inverse_of: :person, dependent: :destroy_async

  # The Spaces the Person is part of
  has_many :spaces, through: :space_memberships

  has_many :invitations, inverse_of: :invitor

  def member_of?(space)
    spaces.include?(space)
  end

  def operator?
    false
  end

  def display_name
    return name if name.present?

    email
  end

  def authenticated?
    true
  end
end
