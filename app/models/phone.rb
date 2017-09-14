class Phone < ApplicationRecord
  
  belongs_to :phone_type
  belongs_to :contact, :inverse_of => :phones
  
  delegate :name, to: :phone_type, prefix: true
  
  validates :phone_type_id, :number, :contact, :presence => true
  validates :phone_type_id, inclusion: { in: Proc.new { PhoneType.pluck(:id) } }
  
  validates :number, format: { with: /\A(?:\+?\d{1,3}\s*-?)?\(?(?:\d{3})?\)?[- ]?\d{3}[- ]?\d{4}\z/, \
      message: "is not a valid format." }
    
end
