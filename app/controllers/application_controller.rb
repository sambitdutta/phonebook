class ApplicationController < ActionController::Base
  # rescue_from DeviseLdapAuthenticatable::LdapException do |exception|
  #   render text: exception, status: 500
  # end
  protect_from_forgery with: :exception
  layout :layout_by_resource
  before_action :authenticate_user!
  # before_action :set_constants, if: proc { request.format.html? }
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_breadcrumbs

  def set_breadcrumbs
    add_breadcrumb 'Home', root_path
  end

  def set_constants
    respond_to do |format|
      format.html do
        # @pods = Pod.env.ids
      end
    end
  end

  def add_breadcrumb(name, url = '')
    @breadcrumbs ||= []
    @breadcrumbs << { name: name, url: url }
  end

  def self.add_breadcrumb(name, url, options = {})
    before_filter options do |controller|
      controller.send(:add_breadcrumb, name, url)
    end
  end

  protected

  def layout_by_resource
    # if user_signed_in?
    'oracle_admin'
    # else
    # 'login'
    # end
  end

  def configure_permitted_parameters
    account_added_attrs = [:username, :email, :password, :password_confirmation, :remember_me, :first_name, :last_name]
    
    signin_added_attrs = [:username, :email, :password, :remember_me]
    
    devise_parameter_sanitizer.permit :sign_in, keys: signin_added_attrs
    devise_parameter_sanitizer.permit :sign_up, keys: account_added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: account_added_attrs
  end
  
  private
  
  def present(object, klass = nil)
    klass ||= (object.class.name+'Presenter').constantize
    klass.new(object, view_context)
  end
end