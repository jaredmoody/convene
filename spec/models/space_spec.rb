# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Space, type: :model do
  it { is_expected.to have_many(:rooms) }
  it do
    is_expected.to belong_to(:entrance).class_name('Room')
                                       .optional(true).dependent(false)
  end

  it { is_expected.to have_many(:invitations).inverse_of(:space) }

  describe '#name' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name) }
  end

  describe '#branded_domain' do
    it { is_expected.to validate_uniqueness_of(:branded_domain).allow_nil }
  end

  describe '#theme' do
    it { is_expected.to validate_inclusion_of(:theme).in_array(Space::THEME_OPTIONS).allow_nil }
  end

  describe '.default' do
    before { FactoryBot.create(:space, :default) }

    subject(:default) { described_class.default }

    it { is_expected.to eql(Space.friendly.find(Neighborhood.config.default_space_slug)) }
  end
end
