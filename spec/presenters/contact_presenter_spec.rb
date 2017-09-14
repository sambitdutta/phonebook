require 'rails_helper'

RSpec.describe ContactPresenter do
  
  before do
    @user = FactoryGirl.create(:user)
    @contact = FactoryGirl.build(:contact, first_name: "Test", last_name: "Test", user: @user)
    @contact.phones.build FactoryGirl.attributes_for(:phone, contact: @contact, number: "8826784854")
    @contact.phones.build FactoryGirl.attributes_for(:phone, contact: @contact)
    @contact.save
  end
  
  describe "#full_name" do
    
    let(:view) { ActionController::Base.new.view_context }
    let(:contact) { ContactPresenter.new(@contact, view) }
        
    it "should match full name" do
      expect(contact.full_name).to eq("Test Test")
    end
    
  end
  
  describe "#primary_phone" do
    
    let(:view) { ActionController::Base.new.view_context }
    let(:contact) { ContactPresenter.new(@contact, view) }
        
    it "should match primary phone" do
      expect(contact.primary_phone).to eq("8826784854")
    end
    
  end
  
  describe "#first_name" do
    
    let(:view) { ActionController::Base.new.view_context }
    let(:contact) { ContactPresenter.new(@contact, view) }
        
    it "should match first name" do
      expect(contact.first_name).to eq("Test")
    end
    
  end
  
  describe "#last_name" do
    let(:view) { ActionController::Base.new.view_context }
    let(:contact) { ContactPresenter.new(@contact, view) }
        
    it "should match last name" do
      expect(contact.last_name).to eq("Test")
    end
  end
  
end