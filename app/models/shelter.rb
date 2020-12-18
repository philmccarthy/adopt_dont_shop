class Shelter < ApplicationRecord
  has_many :pets, dependent: :destroy
  
  def self.desc_by_name
    find_by_sql "SELECT * FROM shelters ORDER BY shelters.name DESC"
  end

  def self.name_and_address(id)
    find_by_sql(
      "SELECT *
       FROM shelters
       WHERE shelters.id = #{id}")
  end

  def self.pending_applications
    joins(pets: :applications)
      .where(applications: {status: 1})
      .distinct
      .order(:name)
  end
end