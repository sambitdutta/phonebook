module Prepopulate
  
  extend ActiveSupport::Concern
  
  included do
    
  end
  
  class_methods do
    
    def prepopulate
      100.times do |i|
        
        begin
  
          user = ::User.get_dummy_user
          user.save
  
          50.times do |j|
            contact = ::Contact.get_dummy_contact user
            contact.save
          end
        
        rescue ActiveRecord::RecordNotUnique => e
          
          retry
          
        end
  
      end
    end
    
  end
  
end

