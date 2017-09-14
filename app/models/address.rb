class Address < ApplicationRecord
  
  belongs_to :address_type
  belongs_to :country
  belongs_to :contact, :inverse_of => :addresses
  
  delegate :name, to: :address_type, prefix: true
  delegate :name, to: :country, prefix: true
  
  validates :address_type_id, :address_1, :city, :country_id, :contact, :presence => true
  validates :address_type_id, inclusion: { in: Proc.new { AddressType.all_ids } }
#  validates :country, inclusion: { in: Proc.new { Country.pluck(:id).map(&:to_i) } }
  
end
