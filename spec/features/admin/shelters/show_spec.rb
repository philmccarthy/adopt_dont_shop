require 'rails_helper'

RSpec.describe 'admin shelter show page', type: :feature do
  it 'sees that shelter name and full address' do
    shelter1 = Shelter.create!(name: "Shady Shelter", address: "123 Shady Ave", city: "Denver", state: "CO", zip: 80011)
    pet1 = shelter1.pets.create!(image:"", name: "Thor", description: "dog", approximate_age: 2, sex: "male")
    pet2 = shelter1.pets.create!(image:"", name: "Athena", description: "cat", approximate_age: 3, sex: "female")
    pet3 = shelter1.pets.create!(image:"", name: "Zeus", description: "dog", approximate_age: 4, sex: "male")
    
    visit admin_shelter_path(shelter1)

    expect(page).to have_content(shelter1.name)
    expect(page).to have_content(shelter1.address)
    expect(page).to have_content(shelter1.city)
    expect(page).to have_content(shelter1.state)
    expect(page).to have_content(shelter1.zip)
  end

  it 'has a statistics section' do
    shelter1 = Shelter.create!(name: "Shady Shelter", address: "123 Shady Ave", city: "Denver", state: "CO", zip: 80011)
    pet1 = shelter1.pets.create!(image:"", name: "Thor", description: "dog", approximate_age: 2, sex: "male")
    pet2 = shelter1.pets.create!(image:"", name: "Athena", description: "cat", approximate_age: 3, sex: "female")
    pet3 = shelter1.pets.create!(image:"", name: "Zeus", description: "dog", approximate_age: 4, sex: "male")

    visit admin_shelter_path(shelter1)

    within('#shelter-stats') do
      expect(page).to have_content(shelter1.pets.average_adoptable_age)
      expect(page).to have_content(shelter1.pets.count_adoptable)
      expect(page).to have_content(shelter1.pets.count_adopted)
    end
  end

  it 'has a action required section' do
    shelter_1 = create(:shelter)
    app_1 = create(:application, status: 'Pending')
    pet_1 = create(:pet, name: 'Bruiser', shelter: shelter_1)
    pet_2 = create(:pet, name: 'Blanche', shelter: shelter_1)
    pet_3 = create(:pet, name: 'Bowwow', shelter: shelter_1)
    pet_4 = create(:pet, name: 'Mary', shelter: shelter_1)
    ApplicationPet.create(application: app_1, pet: pet_1)
    ApplicationPet.create(application: app_1, pet: pet_2)
    ApplicationPet.create(application: app_1, pet: pet_3, status: 1)
    ApplicationPet.create(application: app_1, pet: pet_4, status: 0)
    
    visit admin_shelter_path(shelter_1)

    within('#shelter-action-req') do
      expect(page).to have_content(pet_1.name)
      expect(page).to have_content(pet_2.name)
      expect(page).to_not have_content(pet_3.name)
      expect(page).to_not have_content(pet_4.name)
    end
  end
end