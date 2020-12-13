require 'rails_helper'

RSpec.describe 'application show page', type: :feature do
  describe 'as a visitor' do
    before(:each) do
      @app_1 = create(:application)
      @pet = create(:pet, name: 'Bruiser')
    end

    it 'when i visit an application show page' do
      visit "/applications/#{@app_1.id}"

      within("#app-#{@app_1.id}") do
        expect(page).to have_content(@app_1.name)
        expect(page).to have_content(@app_1.street)
        expect(page).to have_content(@app_1.city)
        expect(page).to have_content(@app_1.state)
        expect(page).to have_content(@app_1.postal_code)
        expect(page).to have_content(@app_1.status)
      end
    end

    it 'can search for pets and add to applicaiton' do
      visit "/applications/#{@app_1.id}"

      within("#app-#{@app_1.id}-search") do
        fill_in 'search', with: 'Bruiser'
        click_button 'Search'
        expect(page).to have_content(@pet.name)
      end

      within("#adopt-#{@pet.id}") do
        click_link 'ADOPT'
        # names of all pets that this application is (all names of pets should be links to their show page)
      end

      within("#app-#{@app_1.id}-pets-added") do
        expect(page).to have_content(@pet.name)
      end

      within("#app-#{@app_1.id}-submit") do
        fill_in 'description', with: 'I love pets!'
        click_button 'Submit Application'
      end
    end
  end
end