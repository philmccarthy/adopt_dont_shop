class Shelter < ApplicationRecord
  has_many :pets, dependent: :destroy
  
  def self.desc_by_name
    find_by_sql "SELECT * FROM shelters ORDER BY shelters.name DESC"
  end

  def self.name_and_address(id)
    find_by_sql(
      "SELECT shelters.name, shelters.address, shelters.city, shelters.state, shelters.zip
       FROM shelters
       WHERE shelters.id = #{id}")
  end
end