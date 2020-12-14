require 'rails_helper'

RSpec.describe 'admin application show page', type: :feature do
  describe 'it displays application info with approve and reject buttons for pets' do
    before(:each) do
      @app_1 = create(:application)
      @pet = create(:pet, name: 'Bruiser')
      @pet = create(:pet, name: 'Blanche')
      @pet = create(:pet, name: 'Bowwow')
    end

    it 'can approve and reject specific pets on an application' do
      expect(page).to have_button('Approve')
      expect(page).to have_button('Reject')
    end
  end
end