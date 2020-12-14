require 'rails_helper'

RSpec.describe ApplicationPet, type: :model do

  describe 'relationships' do
    it {should belong_to :application}
    it {should belong_to :pet}
  end

  describe 'class methods' do
    it '::find_by_keys' do
      app = create(:application)
      pet = create(:pet)
      app_pet = ApplicationPet.create!(application: app, pet: pet)
      expect(ApplicationPet.find_by_keys(app.id, pet.id).first).to eq(app_pet)
    end

    it '::find_by_pet' do
      app_1 = create(:application)
      app_2 = create(:application)
      pet_1 = create(:pet)
      pet_2 = create(:pet)
      pet_3 = create(:pet)
      ApplicationPet.create!(application: app_1, pet: pet_1)
      ApplicationPet.create!(application: app_1, pet: pet_2)
      ApplicationPet.create!(application: app_1, pet: pet_3)
      ApplicationPet.create!(application: app_2, pet: pet_1)
      ApplicationPet.create!(application: app_2, pet: pet_2)
      expect(ApplicationPet.find_by_pet(pet_1).count).to eq(2)
    end

    it '::find_by_app' do
      app_1 = create(:application)
      app_2 = create(:application)
      pet_1 = create(:pet)
      pet_2 = create(:pet)
      app_pet_1 = ApplicationPet.create!(application: app_1, pet: pet_1)
      app_pet_2 = ApplicationPet.create!(application: app_2, pet: pet_2)
      expect(ApplicationPet.find_by_app(app_2).first).to eq(app_pet_2)
    end
  end

  describe 'instance methods' do
    it '#approve' do
      app = create(:application)
      pet = create(:pet)
      app_pet = ApplicationPet.create!(application: app, pet: pet)
      expect(app_pet.status).to eq(nil)
      app_pet.approve
      expect(app_pet.status).to eq("approved")
    end

    it '#reject' do
      app = create(:application)
      pet = create(:pet)
      app_pet = ApplicationPet.create!(application: app, pet: pet)
      expect(app_pet.status).to eq(nil)
      app_pet.reject
      expect(app_pet.status).to eq("rejected")
    end
  end
end