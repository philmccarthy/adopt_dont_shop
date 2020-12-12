FactoryBot.define do
  factory :application do
    name { FFaker::Name.name }
    street { FFaker::AddressUS.street_address }
    city { FFaker::AddressUS.city }
    state { FFaker::AddressUS.state_abbr }
    postal_code { FFaker::AddressUS.zip_code }
    description { FFaker::Lorem.paragraph }
  end

  factory :pet do
    image { ['cat.jpg', 'dog.jpg'].sample }
    name { FFaker::Name.first_name}
    approximate_age { rand(1..14) }
    description { FFaker::Lorem.paragraph }
    adoptable { true }
    sex { [0, 1].sample }
    shelter
    # application_pets
  end

  factory :shelter do
    name { FFaker::Company.name }
    address { FFaker::AddressUS.street_address }
    city { FFaker::AddressUS.city }
    state { FFaker::AddressUS.state_abbr }
    zip { FFaker::AddressUS.zip_code }
  end
end