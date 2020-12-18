require 'rails_helper'

describe Shelter, type: :model do
  describe 'relationships' do
    it { should have_many :pets }
  end

  describe 'class methods' do
    describe '::desc_by_name' do
      it 'orders shelters alpha desc by name' do
        shelter1 = create(:shelter, name: 'Alphabet')
        shelter2 = create(:shelter, name: 'Xylophone')

        shelters = Shelter.desc_by_name
        expect(shelters.first).to eq(shelter2)
        expect(shelters.last).to eq(shelter1)
      end
    end

    describe '::name_and_address' do
      it 'returns shelter name and address' do
        shelter1 = create(:shelter)
        deets = Shelter.name_and_address(shelter1.id).first

        expect(deets.name).to eq(shelter1.name)
        expect(deets.address).to eq(shelter1.address)
        expect(deets.city).to eq(shelter1.city)
        expect(deets.state).to eq(shelter1.state)
        expect(deets.zip).to eq(shelter1.zip)
      end
    end

    describe '::pending_applications' do
      it 'returns shelters with pending applications ordered by name' do
        shelter_1 = create(:shelter, name: 'Xylophone')
        shelter_2 = create(:shelter, name: 'Saxophone')
        shelter_3 = create(:shelter, name: 'Alphabet')
        app_1 = create(:application, status: 'Pending')
        app_2 = create(:application, status: 'Pending')
        app_3 = create(:application, status: 'Pending')
        pet_1 = create(:pet, name: 'Bruiser', shelter: shelter_1)
        pet_2 = create(:pet, name: 'Blanche', shelter: shelter_2)
        pet_3 = create(:pet, name: 'Bowwow', shelter: shelter_3)
        ApplicationPet.create(application: app_1, pet: pet_1)
        ApplicationPet.create(application: app_2, pet: pet_2)
        ApplicationPet.create(application: app_3, pet: pet_3)

        expect(Shelter.pending_applications).to include(shelter_1)
        expect(Shelter.pending_applications).to include(shelter_2)
        expect(Shelter.pending_applications).to include(shelter_3)
        expect(Shelter.pending_applications.first).to eq(shelter_3)
        expect(Shelter.pending_applications.last).to eq(shelter_1)
      end
    end
  end
end


