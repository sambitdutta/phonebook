class Contact < ApplicationRecord
  belongs_to :user
  
  has_many :addresses, :inverse_of => :contact, :dependent => :destroy
  has_many :phones, :inverse_of => :contact, :dependent => :destroy
  
  accepts_nested_attributes_for :addresses, allow_destroy: true, :reject_if => :address_blank
  accepts_nested_attributes_for :phones, allow_destroy: true
  
  PHONES_SIZE_MIN = 1
  
  validates :first_name, :user_id, :presence => true
  
  validate :phones_count

  private

  def phones_count_valid?
    phones.reject(&:marked_for_destruction?).size > 0
  end

  def phones_count
    errors.add(:base, 'You must provide at least one phone') unless phones_count_valid?
  end
  
  def address_blank(attr)
    
    return true if attr[:address_1].blank? && attr[:address_2].blank? && attr[:city].blank? \
      && attr[:pin_code].blank? && attr[:state].blank? && attr[:country_id].blank?
    
    return false
    
  end
  
  def self.get_dummy_contact user
    @contact = FactoryGirl.build(:contact, user: user)
    @contact.phones.build FactoryGirl.attributes_for(:phone, contact: @contact)
    @contact.addresses.build FactoryGirl.attributes_for(:address, contact: @contact, country_id: Country.first.id)
  end
  
  
end
