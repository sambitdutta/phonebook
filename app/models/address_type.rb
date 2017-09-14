class AddressType < ApplicationRecord
  
  def self.all_ids
    self.pluck(:id)
  end
  
end
