require 'rails_helper'

RSpec.describe Property, type: :model do
  context 'Validations' do
    context 'Name' do
      # Assert
      it { is_expected.to validate_presence_of(:name) }
    end
  end
end
