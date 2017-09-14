require 'rails_helper'

RSpec.describe ContactsController, type: :controller do
  
  let(:user) { FactoryGirl.create(:user) }
  
  describe "#index" do
    
    context "as authorized user" do
      
      before(:each) do
        sign_in user
      end
      
      it "should return http success" do
        get :index
        expect(response).to be_success
      end
      
      it "should render index template" do
        get :index
        expect(response).to render_template :index
      end
      
      it "populates an array of contacts for the logged in user" do
        
        contact1 = FactoryGirl.build(:contact, first_name: 'Sambit', last_name: "Dutta", user: user)
        contact1.phones.build FactoryGirl.attributes_for(:phone, contact: contact1)
        contact1.addresses.build FactoryGirl.attributes_for(:address, contact: contact1, country_id: Country.first.id)
        contact1.save
        
        contact2 = FactoryGirl.build(:contact, first_name: 'Debanjan', last_name: "Paul", user: user)
        contact2.phones.build FactoryGirl.attributes_for(:phone, contact: contact2)
        contact2.addresses.build FactoryGirl.attributes_for(:address, contact: contact2, country_id: Country.last.id)
        contact2.save
        
        get :index
        expect(assigns(:contacts)).to match_array([contact2, contact1])
        
      end
      
      it "matches the count of array of contacts for the logged in user" do
        
        contact1 = FactoryGirl.build(:contact, first_name: 'Sambit', last_name: "Dutta", user: user)
        contact1.phones.build FactoryGirl.attributes_for(:phone, contact: contact1)
        contact1.addresses.build FactoryGirl.attributes_for(:address, contact: contact1, country_id: Country.first.id)
        contact1.save
        
        contact2 = FactoryGirl.build(:contact, first_name: 'Debanjan', last_name: "Paul", user: user)
        contact2.phones.build FactoryGirl.attributes_for(:phone, contact: contact2)
        contact2.addresses.build FactoryGirl.attributes_for(:address, contact: contact2, country_id: Country.last.id)
        contact2.save
        
        get :index
        expect(assigns(:contacts).count).to eq(2)
        
      end
      
    end
    
    context "as unauthorized user" do
      
      it "returns a 302 response" do
        get :index
        expect(response).to have_http_status "302"
      end
      
    end
    
  end
  
  describe "#create" do
    
    context "as unauthorized user" do
      
      it "returns a 302 response" do
        post :create, params: { contact: { first_name: "testing123", last_name: "testing123", \
              phones_attributes: {'0' => {number: "9999999999", phone_type_id: PhoneType.first.id}} } \
          }
        expect(response).to have_http_status "302"
      end
      
    end
    
    context "as authorized user" do
      
      before(:each) do
        sign_in user
      end
      
      it "changes count by 1" do
        
        expect {
          post :create, params: { contact: { first_name: "testing123", last_name: "testing123", \
                phones_attributes: {'0' => {number: "9999999999", phone_type_id: PhoneType.first.id}} } \
            }
        }.to change(user.contacts, :count).by(1)
        
      end
      
      it "redirects to corresponding contact page" do
        
        post :create, params: { 
          contact: FactoryGirl.attributes_for(:contact).merge({ phones_attributes: {'0' => FactoryGirl.attributes_for(:phone)} }) 
          
        }       
 
        expect(response).to redirect_to contact_path(assigns(:contact))
        
      end
      
      it "renders new again with validation errors" do
        
        post :create, params: { 
          contact: FactoryGirl.attributes_for(:contact) 
        }       
 
        expect(response).to render_template :new
        
      end
      
    end
    
  end
  
  describe "#new" do
    
    context "as unauthorized user" do
      
      it "returns a 302 response" do
        get :new
        expect(response).to have_http_status "302"
      end
      
    end
    
    context "as authorized user" do
      
      before(:each) do
        sign_in user
      end
      
      it "renders new template" do
        get :new
        expect(response).to render_template :new
      end
      
    end
    
  end
  
  describe "#edit" do
    
    before do
      @contact = FactoryGirl.build(:contact, first_name: 'Sambit', last_name: "Dutta", user: user)
      @contact.phones.build FactoryGirl.attributes_for(:phone, contact: @contact)
      @contact.addresses.build FactoryGirl.attributes_for(:address, contact: @contact, country_id: Country.first.id)
      @contact.save
    end
    
    context "as unauthorized user" do
      
      it "returns a 302 response" do
        get :edit, params: { id: @contact.id }
        expect(response).to have_http_status "302"
      end
      
    end
    
    context "as authorized user" do
      
      before(:each) do
        sign_in user
      end
      
      it "renders edit template" do
        get :edit, params: { id: @contact.id }
        expect(response).to render_template :edit
      end
      
      it "redirects for unauthorized access" do
        
        user_1 =  FactoryGirl.create(:user, username: 'sample.test2', email: 'sample.test2@gmail.com')
        
        @contact2 = FactoryGirl.build(:contact, first_name: 'Sambit', last_name: "Dutta", user: user_1)
        @contact2.phones.build FactoryGirl.attributes_for(:phone, contact: @contact2)
        @contact2.addresses.build FactoryGirl.attributes_for(:address, contact: @contact2, country_id: Country.first.id)
        @contact2.save
        
        get :edit, params: { id: @contact2.id }
        expect(response).to redirect_to root_path
      end
      
    end
    
  end
  
  describe "#update" do
    
    before(:each) do
      @contact = FactoryGirl.build(:contact, first_name: 'Sambit', last_name: "Dutta", user: user)
      @contact.phones.build FactoryGirl.attributes_for(:phone, contact: @contact)
      @contact.addresses.build FactoryGirl.attributes_for(:address, contact: @contact, country_id: Country.first.id)
      @contact.save
    end
    
    context "as unauthorized user" do
      
      it "returns a 302 response" do
        put :update, params: { id: @contact, contact: { first_name: "testing123", last_name: "testing123",
            phones_attributes: { '0' => {id: @contact.phones.first.id.to_s, _destroy: 'false', number: "9999999999", phone_type_id: PhoneType.first.id} },
            addresses_attributes: { '0' => {id: @contact.addresses.first.id.to_s, _destroy: 'false', address_type_id: AddressType.first.id, address_1: 'test', address_2: 'test', city: "Kolkata", pin_code: '700114', state: 'West Bengal', country_id: Country.last.id} }
          }
        }
        expect(response).to have_http_status "302"
      end
      
    end
    
    context "as authorized user" do
      
      before(:each) do
        sign_in user
      end
      
      it "matches updated first name and last name" do
        put :update, params: { id: @contact, contact: { first_name: "testing123", last_name: "testing123",
            phones_attributes: { '0' => {id: @contact.phones.first.id.to_s, _destroy: 'false', number: "9999999999", phone_type_id: PhoneType.first.id} },
            addresses_attributes: { '0' => {id: @contact.addresses.first.id.to_s, _destroy: 'false', address_type_id: AddressType.first.id, address_1: 'test', address_2: 'test', city: "Kolkata", pin_code: '700114', state: 'West Bengal', country_id: Country.last.id} }
          }
        }
        expect(assigns(:contact).first_name).to eq('testing123')
        expect(assigns(:contact).last_name).to eq('testing123')
      end
      
      it "renders edit with validation error" do
        put :update, params: { id: @contact, contact: { first_name: "testing123", last_name: "testing123",
            phones_attributes: { '0' => {id: @contact.phones.first.id.to_s, _destroy: 'true'} },
            addresses_attributes: { '0' => {id: @contact.addresses.first.id.to_s, _destroy: 'false', address_type_id: AddressType.first.id, address_1: 'test', address_2: 'test', city: "Kolkata", pin_code: '700114', state: 'West Bengal', country_id: Country.last.id} }
          }
        }
        expect(response).to render_template :edit
      end
      
      it "redirects for unauthorized access" do
        
        user_1 =  FactoryGirl.create(:user, username: 'sample.test', email: 'sample.test@gmail.com')
        
        @contact2 = FactoryGirl.build(:contact, first_name: 'Sambit', last_name: "Dutta", user: user_1)
        @contact2.phones.build FactoryGirl.attributes_for(:phone, contact: @contact2)
        @contact2.addresses.build FactoryGirl.attributes_for(:address, contact: @contact2, country_id: Country.first.id)
        @contact2.save
        
        put :update, params: { id: @contact2, contact: { first_name: "testing123", last_name: "testing123",
            phones_attributes: { '0' => {id: @contact2.phones.first.id.to_s, _destroy: 'true'} },
            addresses_attributes: { '0' => {id: @contact2.addresses.first.id.to_s, _destroy: 'false', address_type_id: AddressType.first.id, address_1: 'test', address_2: 'test', city: "Kolkata", pin_code: '700114', state: 'West Bengal', country_id: Country.last.id} }
          }
        }
        expect(response).to redirect_to root_path
      end
      
    end
    
  end
  
  describe "#destroy" do
    
    before(:each) do
      @contact = FactoryGirl.build(:contact, first_name: 'Sambit', last_name: "Dutta", user: user)
      @contact.phones.build FactoryGirl.attributes_for(:phone, contact: @contact)
      @contact.addresses.build FactoryGirl.attributes_for(:address, contact: @contact, country_id: Country.first.id)
      @contact.save
    end
    
    context "as unauthorized user" do
      
      it "returns a 302 response" do
        delete :destroy, params: { id: @contact.id }
        expect(response).to have_http_status "302"
      end
      
      it "should not delete record" do
        expect {
          delete :destroy, params: { id: @contact.id }
        }.to change(user.contacts, :count).by(0)
        
      end
      
    end
    
    context "as authorized user" do
      
      before(:each) do
        sign_in user
      end
      
      it "should delete record" do
      
        expect {
          delete :destroy, params: { id: @contact.id }
        }.to change(user.contacts, :count).by(-1)
        
      end
      
      it "redirects for unauthorized access" do
        
        user_1 =  FactoryGirl.create(:user, username: 'sample.test3', email: 'sample.test3@gmail.com')
        
        @contact2 = FactoryGirl.build(:contact, first_name: 'Sambit', last_name: "Dutta", user: user_1)
        @contact2.phones.build FactoryGirl.attributes_for(:phone, contact: @contact2)
        @contact2.addresses.build FactoryGirl.attributes_for(:address, contact: @contact2, country_id: Country.first.id)
        @contact2.save
        
        
        delete :destroy, params: { id: @contact2.id }
        
        expect(response).to redirect_to root_path
      end
      
    end
    
  end

end
