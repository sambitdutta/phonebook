class ContactsController < ApplicationController
  
  before_action :validate_contact, only: [:edit, :update, :show, :destroy]
  
  def index
    @contacts = Contact.where(user_id: current_user.id).order("first_name, last_name ASC")
  end
  
  def new
    @contact = Contact.new
    1.times { @contact.phones.build }
  end
  
  def show
    add_breadcrumb present(@contact).full_name, contact_path(@contact)
  end
  
  def destroy
    @contact.destroy!
    respond_to do |format|
      format.html {
        head :ok 
      }
      
      format.js {
        head :ok
      }
    end
  end
  
  def edit
    add_breadcrumb present(@contact).full_name, edit_contact_path(@contact)
  end
  
  def update
    @contact.assign_attributes(contact_params)
    if @contact.save
      respond_to do |format|
        format.html {
          flash[:notice] = "Contact updated successfully"
          redirect_to contact_path(@contact)
        }
      end
    else
      respond_to do |format|
        format.html {
          flash.now[:error] = "Failed to update contact"
          render :edit
        }
      end
    end
  end
  
  def create
    @contact = Contact.new(contact_params.merge({user_id: current_user.id}))
    if @contact.save
      respond_to do |format|
        format.html {
          flash[:notice] = "Contact saved successfully"
          redirect_to contact_path(@contact)
        }
      end
    else
      Rails.logger.info @contact.errors.inspect
      respond_to do |format|
        format.html {
          flash.now[:error] = "Failed to save contact"
          render :new
        }
      end
    end
  end
  
  private
  
  def contact_params
     params.require(:contact).permit(:first_name, :last_name, \
         :phones_attributes => [:phone_type_id, :number, :_destroy, :id], \
         :addresses_attributes => [:address_type_id, :address_1, :address_2, :city, :pin_code, :state, :country_id, :_destroy, :id])
     
  end
  
  def validate_contact
    @contact =  Contact.where(id: params[:id], user_id: current_user.id).first
      
    unless @contact.present?
      respond_to do |format|
        format.html {
          flash[:error] = "Unable to find contact"
          redirect_to root_path
        }
      end
    end
  end
  
end
