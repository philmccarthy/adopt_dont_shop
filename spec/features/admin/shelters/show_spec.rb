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
    end
  end
end