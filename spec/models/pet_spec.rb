require 'rails_helper'

describe Pet, type: :model do
  describe 'relationships' do
    it { should belong_to :shelter }
    it { should have_many :application_pets }
    it { should have_many(:applications).through(:application_pets)}
  end

  describe 'validations' do
    it {should validate_presence_of :name}
    it {should validate_presence_of :description}
    it {should validate_presence_of :sex}
    it {should validate_numericality_of(:approximate_age).is_greater_than_or_equal_to(0)}

    describe 'class methods' do
      describe '::search_by_name' do
        it 'finds pets by partial name match and excludes pets that are not adoptable' do
          shelter = Shelter.create!(name: 'Pet Rescue', address: '123 Adoption Ln.', city: 'Denver', state: 'CO', zip: '80222')
          pet_1 = shelter.pets.create!(sex: :female, name: "Fluffy", approximate_age: 3, description: 'super cute', adoptable: true)
          pet_2 = shelter.pets.create!(sex: :female, name: "Floofy", approximate_age: 5, description: 'super cute', adoptable: false)

          expect(Pet.search_by_name('fl')).not_to include(pet_2)
        end
      end

      describe '.average_age (scope)' do
        it 'returns average age of pets collection' do
          shelter = Shelter.create!(name: 'Pet Rescue', address: '123 Adoption Ln.', city: 'Denver', state: 'CO', zip: '80222')
          shelter.pets.create!(sex: :female, name: "Fluffy", approximate_age: 3, description: 'super cute', adoptable: true)
          shelter.pets.create!(sex: :female, name: "Floofy", approximate_age: 5, description: 'super cute', adoptable: false)
          shelter.pets.create!(sex: :female, name: "Gloofy", approximate_age: 5, description: 'super cute', adoptable: true)
          expect(shelter.pets.average_adoptable_age).to eq(4)
        end
      end

      describe '.count_adoptable (scope)' do
        it 'returns count of adoptable pets' do
          shelter = Shelter.create!(name: 'Pet Rescue', address: '123 Adoption Ln.', city: 'Denver', state: 'CO', zip: '80222')
          shelter.pets.create!(sex: :female, name: "Fluffy", approximate_age: 3, description: 'super cute', adoptable: true)
          shelter.pets.create!(sex: :female, name: "Floofy", approximate_age: 5, description: 'super cute', adoptable: false)
          shelter.pets.create!(sex: :female, name: "Gloofy", approximate_age: 5, description: 'super cute', adoptable: true)
          expect(shelter.pets.count_adoptable).to eq(2)
        end
      end

      describe '::count_adopted' do
        it 'returns count of adopted pets' do
          shelter = Shelter.create!(name: 'Pet Rescue', address: '123 Adoption Ln.', city: 'Denver', state: 'CO', zip: '80222')
          pet_1 = shelter.pets.create!(sex: :female, name: "Fluffy", approximate_age: 3, description: 'super cute')
          pet_2 = shelter.pets.create!(sex: :female, name: "Floofy", approximate_age: 5, description: 'super cute')
          pet_3 = shelter.pets.create!(sex: :female, name: "Gloofy", approximate_age: 5, description: 'super cute')
          app_1 = create(:application, status: 2)
          app_2 = create(:application, status: 3)
          ApplicationPet.create!(application: app_1, pet: pet_1)
          ApplicationPet.create!(application: app_1, pet: pet_2)

          ApplicationPet.create!(application: app_2, pet: pet_3)
          
          expect(shelter.pets.count_adopted).to eq(2)
        end
      end
    end

    it 'is created as adoptable by default' do
      shelter = Shelter.create!(name: 'Pet Rescue', address: '123 Adoption Ln.', city: 'Denver', state: 'CO', zip: '80222')
      pet = shelter.pets.create!(name: "Fluffy", approximate_age: 3, sex: 'male', description: 'super cute')
      expect(pet.adoptable).to eq(true)
    end

    it 'can be created as not adoptable' do
      shelter = Shelter.create!(name: 'Pet Rescue', address: '123 Adoption Ln.', city: 'Denver', state: 'CO', zip: '80222')
      pet = shelter.pets.create!(adoptable: false, name: "Fluffy", approximate_age: 3, sex: 'male', description: 'super cute')
      expect(pet.adoptable).to eq(false)
    end

    it 'can be male' do
      shelter = Shelter.create!(name: 'Pet Rescue', address: '123 Adoption Ln.', city: 'Denver', state: 'CO', zip: '80222')
      pet = shelter.pets.create!(sex: :male, name: "Fluffy", approximate_age: 3, description: 'super cute')
      expect(pet.sex).to eq('male')
      expect(pet.male?).to be(true)
      expect(pet.female?).to be(false)
    end

    it 'can be female' do
      shelter = Shelter.create!(name: 'Pet Rescue', address: '123 Adoption Ln.', city: 'Denver', state: 'CO', zip: '80222')
      pet = shelter.pets.create!(sex: :female, name: "Fluffy", approximate_age: 3, description: 'super cute')
      expect(pet.sex).to eq('female')
      expect(pet.female?).to be(true)
      expect(pet.male?).to be(false)
    end
  end
end
