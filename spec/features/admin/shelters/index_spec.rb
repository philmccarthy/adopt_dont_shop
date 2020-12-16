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

    it 'I see all Shelters with pending applications listed alphabetically' do
      shelter_1 = create(:shelter, name: 'Xylophone')
      shelter_2 = create(:shelter, name: 'Saxophone')
      shelter_3 = create(:shelter, name: 'Alphabet')
      app_1 = create(:application, status: 'Pending')
      pet_1 = create(:pet, name: 'Bruiser', shelter: shelter_1)
      pet_2 = create(:pet, name: 'Blanche', shelter: shelter_2)
      pet_3 = create(:pet, name: 'Bowwow', shelter: shelter_3)
      ApplicationPet.create(application: app_1, pet: pet_1)
      ApplicationPet.create(application: app_1, pet: pet_2, status: 0)
      ApplicationPet.create(application: app_1, pet: pet_3)
      visit admin_shelters_path

      within('#shelters-with-pending-apps') do
        expect(page).to have_content('Shelters with Pending Applications')
        expect(page).to have_content(shelter_1.name)
        expect(page).to_not have_content(shelter_2.name)
        expect(page).to have_content(shelter_3.name)
        expect(shelter_3.name).to appear_before(shelter_1.name)
      end
    end
  end
end