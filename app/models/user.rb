class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # LDAP OFF uncomment line blow
  devise :database_authenticatable, :rememberable, :trackable, :registerable, :authentication_keys => [:login]
  # LDAP ON uncomment line below:
  # devise :database_authenticatable, :ldap_authenticatable, :rememberable, :trackable

  after_create :assign_default_role
  
  include Prepopulate

  def assign_default_role
    self.add_role(:user) if self.roles.blank?
  end
  
  validates :username, :presence => true, :uniqueness => {
    :case_sensitive => false
  }
  
  validates :first_name, :last_name, :presence => true
  
  validate :validate_username
  
  validates_format_of :username, with: /^[a-zA-Z0-9_\.]*$/, :multiline => true
  
  has_many :contacts, :dependent => :destroy
  
  def validate_username
    if User.where(email: username).exists?
      errors.add(:username, :invalid)
    end
  end  
       
  def login=(login)
    @login = login
  end

  def login
    @login || self.username || self.email
  end
  
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_hash).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      conditions[:email].downcase! if conditions[:email]
      where(conditions.to_hash).first
    end
  end
  
  def self.get_dummy_user
    FactoryGirl.build(:user, username: 'test.test'+(Math.send(:rand)*10000).to_i.to_s)
  end
end
