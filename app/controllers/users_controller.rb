class UsersController < ApplicationController
  # set @user for specific method/actions
  before_action :set_user, only: %i[edit update]
  # ensure admin user for all method/actions
  before_action :ensure_admin

  # Breadcrumb navigation
  def set_breadcrumbs
    super
    add_breadcrumb 'User Admin', users_path
  end

  def index
    @users = User.all
  end

  def edit
    add_breadcrumb @user.username
    # cancancan ability class instance variable to check admin rights in edit
    @ability = Ability.new(@user)
  end

  def update
    ## IF User form updates correctly
    if (@user.update_attributes(user_params)) && (user_params[:admin] == '1')
      ## Redirect to user show action
      flash[:notice] = 'Admin role successfully added to user'
      # rolify add_role - adds row to user_roles table:
      @user.add_role 'admin'
      redirect_to(users_path(@user))
    elsif (@user.update_attributes(user_params)) && (user_params[:admin] == '0')
      flash[:notice] = 'Admin role successfully removed from user'
      # rolify remove_role - removes row from user_roles table
      @user.remove_role 'admin'
      redirect_to(users_path(@user))
    ## Update failed, display the edit form again to be fixed by user
    else
      render('edit')
    end
  end

  private

  def ensure_admin
    return if can? :manage, User
    flash[:error] = 'Not authorized to modify Users. Admin users only.'
    redirect_to root_path
  end

  def user_params
    params.require(:user).permit(:admin)
  end

  def set_user
    @user = User.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:error] = 'This action is not allowed.'
    redirect_to users_path
  end
end
