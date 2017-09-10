class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # LDAP OFF uncomment line blow
  devise :database_authenticatable, :rememberable, :trackable, :registerable
  # LDAP ON uncomment line below:
  # devise :database_authenticatable, :ldap_authenticatable, :rememberable, :trackable

  after_create :assign_default_role

  def assign_default_role
    self.add_role(:user) if self.roles.blank?
  end
end
