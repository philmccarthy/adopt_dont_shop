class ApplicationPet < ApplicationRecord
  belongs_to :application
  belongs_to :pet
  validates :pet_id, :uniqueness => { :scope => :application_id }

  enum status: [:approved, :rejected]

  def self.find_by_keys(app_id, pt_id)
    find_by(application_id: app_id, pet_id: pt_id)
  end

  def self.find_by_pet(pt_id)
    where(pet_id: pt_id)
  end

  def self.find_by_app(app_id)
    where(application_id: app_id)
  end

  def approve
    update(status: 0)
  end

  def reject
    update(status: 1)
  end
end