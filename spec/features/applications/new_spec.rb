require 'rails_helper'

RSpec.describe 'application new page', type: :feature do
  describe 'as a visitor i see a form' do
    it 'creates new application when submitted' do
      visit new_application_path

      fill_in 'Name', with: 'Bob Bobson'
      fill_in 'Street', with: '1234 Real Street'
      fill_in 'City', with: 'Bobton'
      fill_in 'State', with: 'CO'
      fill_in 'Postal code', with: '80210'
      
      before = Application.last
      
      click_button 'Submit'

      expect(page.status_code).to eq(200)
      expect(Application.last).to_not eq(before)
    end

    it 'cannot create an application if any field is missing' do
      visit new_application_path

      click_button 'Submit'

      expect(page).to have_content("Name can't be blank. Street can't be blank. City can't be blank. State can't be blank. Postal code can't be blank.")
    end
  end
end