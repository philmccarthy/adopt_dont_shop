require 'rails_helper'

RSpec.describe ApplicationPet, type: :model do
  # describe 'validations' do
  #   it { should validate_presence_of :}
  # end

  describe 'relationships' do
    it {should belong_to :application}
    it {should belong_to :pet}
  end
end