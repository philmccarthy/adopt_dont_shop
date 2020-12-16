require 'rails_helper'

RSpec.describe 'admin application show page', type: :feature do
  describe 'it displays application info with approve and reject buttons for pets' do
    before(:each) do
      @app_1 = create(:application, status: 'Pending')
      @pet_1 = create(:pet, name: 'Bruiser')
      @pet_2 = create(:pet, name: 'Blanche')
      @pet_3 = create(:pet, name: 'Bowwow')
    end

    it 'can approve and reject specific pets on an application to reject an application' do
      app_pet = ApplicationPet.create(application: @app_1, pet: @pet_1)
      app_pet = ApplicationPet.create(application: @app_1, pet: @pet_2)
      app_pet = ApplicationPet.create(application: @app_1, pet: @pet_3)

      visit admin_application_path(@app_1)
      
      within("#admin-tools-#{@pet_1.id}") do
        expect(page).to have_link('APPROVE')
        expect(page).to have_link('REJECT')
        click_link('APPROVE')
        expect(page).to have_content('APPROVED')
      end

      within("#admin-tools-#{@pet_2.id}") do
        click_link('REJECT')
        expect(page).to have_content('REJECTED')
      end

      within("#admin-tools-#{@pet_3.id}") do
        click_link('REJECT')
      end

      within("#app-#{@app_1.id}") do
        expect(page).to have_content('Rejected')
      end
    end

    it 'can approve all app_pets on an application to approve an application' do
      app_pet = ApplicationPet.create(application: @app_1, pet: @pet_1)

      visit admin_application_path(@app_1)
      
      within("#admin-tools-#{@pet_1.id}") do
        click_link('APPROVE')
      end

      within("#app-#{@app_1.id}") do
        expect(page).to have_content('Approved')
      end
    end
  end
end