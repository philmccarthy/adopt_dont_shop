class Application < ApplicationRecord
  has_many :application_pets, dependent: :destroy
  has_many :pets, through: :application_pets

  accepts_nested_attributes_for :pets

  validates_presence_of :name,
                        :street,
                        :city,
                        :state,
                        :postal_code

  enum status: ['In Progress', 'Pending', 'Approved', 'Rejected']

  def is_rejected?
    application_pets.rejected.any? && !pets_outstanding?
  end

  def is_approved?
    !application_pets.rejected.any? && !pets_outstanding?
  end

  def pets_outstanding?
    application_pets.where(status: nil).any?
  end

  def approve
    self.Approved!
  end

  def reject
    self.Rejected!
  end

  def make_pets_unadoptable
    pets.update_all(adoptable: false)
  end
end