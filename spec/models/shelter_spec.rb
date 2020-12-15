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
  end
end
