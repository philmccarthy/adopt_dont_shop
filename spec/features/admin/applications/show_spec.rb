require 'rails_helper'

RSpec.describe 'admin application show page', type: :feature do
  describe 'it displays application info with approve and reject buttons for pets' do
    before(:each) do
      @app_1 = create(:application)
      @pet_1 = create(:pet, name: 'Bruiser')
      @pet_2 = create(:pet, name: 'Blanche')
      @pet_3 = create(:pet, name: 'Bowwow')
    end

    it 'can approve and reject specific pets on an application' do
      ApplicationPet.create!(application: @app_1, pet: @pet_1)
      
      visit admin_application_path(@app_1)
      
      expect(page).to have_link('APPROVE')
      expect(page).to have_link('REJECT')
    end
  end
end