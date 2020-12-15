require 'rails_helper'

RSpec.describe Application, type: :model do
  # describe 'validations' do
  #   it { should validate_presence_of :}
  # end

  describe 'relationships' do
    it {should have_many :application_pets}
    it {should have_many(:pets).through(:application_pets)}
  end

  describe 'instance methods' do
    describe '#is_rejected' do
      it 'can determine if an application is rejected' do
        app = create(:application)
        pet = create(:pet, name: 'Bowwow')
        app_pet = ApplicationPet.create!(application: app, pet: pet, status: nil)
       
        expect(app.is_rejected?).to eq(false)
        
        app_pet.reject
        expect(app.is_rejected?).to eq(true)
        
        app_pet.approve
        expect(app.is_rejected?).to eq(false)
      end
    end

    describe '#is_approved' do
      it 'can determine if an application is approved' do
        app = create(:application)
        pet = create(:pet, name: 'Bowwow')
        app_pet = ApplicationPet.create!(application: app, pet: pet, status: nil)
       
        expect(app.is_approved?).to eq(false)
        
        app_pet.reject
        expect(app.is_approved?).to eq(false)
        
        app_pet.approve
        expect(app.is_approved?).to eq(true)
      end
    end

    describe '#pets_outstanding' do
      it 'can determine if there are any pets that have not been approved or rejected' do
        app = create(:application)
        pet = create(:pet, name: 'Bowwow')
        app_pet = ApplicationPet.create!(application: app, pet: pet, status: nil)

        expect(app.pets_outstanding?).to eq(true)
        app_pet.approve
        expect(app.pets_outstanding?).to eq(false)
      end
    end
    
    describe '#approve' do
      it 'it can change status to approved' do
        app = create(:application)
        pet = create(:pet, name: 'Bowwow')
        app.approve
        expect(app.status).to eq('Approved')
      end
    end

    describe '#reject' do
      it 'it can change status to rejected' do
        app = create(:application)
        pet = create(:pet, name: 'Bowwow')
         app.reject
        expect(app.status).to eq('Rejected')
      end
    end

    describe '#make_pets_unadoptable' do
      it 'changes pets adoptable attribute to false' do
        app_1 = create(:application)
        pet_1 = create(:pet)
        app_pet = ApplicationPet.create!(application: app_1, pet: pet_1, status: 'approved')
        expect(app_1.pets.first.adoptable?).to eq(true)
        app_1.make_pets_unadoptable
        expect(app_1.pets.first.adoptable?).to eq(false)
      end
    end
  end
end