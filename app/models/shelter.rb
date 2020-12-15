class Shelter < ApplicationRecord
  has_many :pets, dependent: :destroy
  
  def self.desc_by_name
    find_by_sql "SELECT * FROM shelters ORDER BY shelters.name DESC"
  end

  # def self.name_and_address
  #   find_by_sql
  # end
end