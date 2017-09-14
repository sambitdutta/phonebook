require 'rails_helper'

RSpec.describe Contact, type: :model do
  
  context "validations: " do
    
    before do
      @user = FactoryGirl.create(:user)
    end
    
    it "should be valid with phone" do
      contact = FactoryGirl.build(:contact, user: @user)
      contact.phones.build FactoryGirl.attributes_for(:phone, contact: contact)
      contact.valid?
      expect(contact).to be_valid
    end
    
    it "should be valid with multiple phones" do
      contact = FactoryGirl.build(:contact, user: @user)
      contact.phones.build FactoryGirl.attributes_for(:phone, contact: contact)
      contact.phones.build FactoryGirl.attributes_for(:phone, contact: contact)
      contact.valid?
      expect(contact).to be_valid
    end
    
    it "should be valid with phone and address" do
      contact = FactoryGirl.build(:contact, user: @user)
      contact.phones.build FactoryGirl.attributes_for(:phone, contact: contact)
      contact.addresses.build FactoryGirl.attributes_for(:address, contact: contact, country_id: Country.first.id)
      contact.valid?
      expect(contact).to be_valid
    end
    
    it "should be invalid without first name" do
      contact = FactoryGirl.build(:contact, :without_first_name, user: @user)
      contact.valid?
      expect(contact.errors[:first_name]).to include("can't be blank")
    end
    
    it "should be valid without last name" do
      contact = FactoryGirl.build(:contact, :without_last_name, user: @user)
      contact.phones.build FactoryGirl.attributes_for(:phone, contact: contact)
      expect(contact).to be_valid
    end
    
    it "should be invalid without atleast one phone" do
      contact = FactoryGirl.build(:contact, user: @user)
      contact.valid?
      expect(contact.errors[:base]).to include("You must provide at least one phone")
    end
    
    it "should be invalid with invalid phone number format" do
      contact = FactoryGirl.build(:contact, user: @user)
      contact.phones.build FactoryGirl.attributes_for(:phone, :invalid_phone, contact: contact)
      contact.valid?
      Rails.logger.info contact.errors.inspect
      expect(contact.errors["phones.number"]).to include("is not a valid format.")
    end
    
    it "should be invalid without phone type" do
      contact = FactoryGirl.build(:contact, user: @user)
      contact.phones.build FactoryGirl.attributes_for(:phone, :without_phone_type, contact: contact)
      contact.valid?
      Rails.logger.info contact.errors.inspect
      expect(contact.errors["phones.phone_type_id"]).to include("can't be blank")
    end
    
    it "should be invalid without address 1" do
      contact = FactoryGirl.build(:contact, user: @user)
      contact.phones.build FactoryGirl.attributes_for(:phone, contact: contact)
      contact.addresses.build FactoryGirl.attributes_for(:address, :without_address_1, contact: contact)
      contact.valid?
      expect(contact).to_not be_valid
    end
    
    it "should be invalid without city" do
      contact = FactoryGirl.build(:contact, user: @user)
      contact.phones.build FactoryGirl.attributes_for(:phone, contact: contact)
      contact.addresses.build FactoryGirl.attributes_for(:address, :without_city, contact: contact)
      contact.valid?
      expect(contact).to_not be_valid
    end
    
    it "should be invalid without country" do
      contact = FactoryGirl.build(:contact, user: @user)
      contact.phones.build FactoryGirl.attributes_for(:phone, contact: contact)
      contact.addresses.build FactoryGirl.attributes_for(:address, :without_country, contact: contact)
      contact.valid?
      expect(contact).to_not be_valid
    end
    
  end
  
end
