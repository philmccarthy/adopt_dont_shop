require 'rails_helper'

RSpec.describe 'application show page', type: :feature do
  describe 'as a visitor' do
    before(:each) do
      @app_1 = create(:application)
    end

    it 'when i visit an application show page' do
      visit "/applications/#{@app_1.id}"

      within("#app-#{@app_1.id}") do
        expect(page).to have_content(@app_1.name)
        expect(page).to have_content(@app_1.street)
        expect(page).to have_content(@app_1.city)
        expect(page).to have_content(@app_1.state)
        expect(page).to have_content(@app_1.postal_code)
        expect(page).to have_content(@app_1.description)
        expect(page).to have_content(@app_1.status)
      end

      within("#app-#{@app_1.id}-pets") do
        expect(page).to have_content(@app_1.pets.first)
        expect(page).to have_content(@app_1.pets.last)
        # names of all pets that this application is for (all names of pets should be links to their show page)
      end
    end
  end
end