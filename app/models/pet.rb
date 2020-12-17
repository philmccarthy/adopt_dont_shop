class Pet < ApplicationRecord
  belongs_to :shelter
  has_many :application_pets, dependent: :destroy
  has_many :applications, through: :application_pets
  
  validates_presence_of :name, :description, :approximate_age, :sex

  validates :approximate_age, numericality: {
              greater_than_or_equal_to: 0
            }

  enum sex: [:female, :male]

  scope :average_adoptable_age, -> { where(adoptable: true).average(:approximate_age) }
  scope :count_adoptable, -> { where(adoptable: true).count}

  def self.search_by_name(search)
    where("lower(name) LIKE ?", "%#{search.downcase}%").where(adoptable: true)
  end

  def self.count_adopted
    joins(:applications)
      .select('pets.*, applications.status')
      .where(applications: { status: 2 })
      .count(:pets)
  end
end
