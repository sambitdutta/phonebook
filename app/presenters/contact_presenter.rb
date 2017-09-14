class ContactPresenter < BasePresenter
  
  presents :contact
  
  delegate :first_name, :last_name, to: :contact
  
  def full_name
    
    contact.first_name + ' ' + contact.last_name
    
  end
  
  def primary_phone
    
    contact.phones.first.number
    
  end
  
  
end
