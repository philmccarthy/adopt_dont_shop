class Application < ApplicationRecord
  has_many :application_pets
  has_many :pets, through: :application_pets

  validates_presence_of :name,
                        :street,
                        :city,
                        :state,
                        :postal_code,
                        :description

  enum status: ['In Progress', 'Pending', 'Approved', 'Rejected']
end