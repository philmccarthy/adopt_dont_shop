require 'rails_helper'

RSpec.describe 'admin application show page', type: :feature do
  describe 'it displays application info with approve and reject buttons for pets' do
    before(:each) do
      @app_1 = create(:application, status: 'Pending')
      @pet_1 = create(:pet, name: 'Bruiser')
      @pet_2 = create(:pet, name: 'Blanche')
      @pet_3 = create(:pet, name: 'Bowwow')
    end

    it 'can approve and reject specific pets on an application' do
      app_pet = ApplicationPet.create(application: @app_1, pet: @pet_1)
      app_pet = ApplicationPet.create(application: @app_1, pet: @pet_2)
      visit admin_application_path(@app_1)
      
      within("#admin-tools-#{@pet_1.id}") do
        expect(page).to have_link('APPROVE')
        expect(page).to have_link('REJECT')
        click_link('APPROVE')
        expect(page).to have_content('APPROVED')
      end
    end
  end
end