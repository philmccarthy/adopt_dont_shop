require 'rails_helper'

RSpec.describe 'admin shelters index page', type: :feature do
  describe 'as a visitor' do
    it 'I see all Shelters in the system listed in reverse alphabetical order by name' do
      shelter_1 = create(:shelter, name: 'Alphabet')
      shelter_2 = create(:shelter, name: 'Xylophone')
      
      visit admin_shelters_path

      expect(page).to have_content(shelter_1.name)
      expect(page).to have_content(shelter_2.name)
      expect(shelter_2.name).to appear_before(shelter_1.name)
    end
  end
end