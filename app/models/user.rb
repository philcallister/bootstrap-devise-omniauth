class User < ActiveRecord::Base

  rolify
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  # :database_authenticatable
  devise :database_authenticatable,
         :omniauthable, # ***** IS_TAG *****
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me
  attr_accessible :role_ids, :as => :admin
  attr_accessible :provider, :uid
  # attr_accessible :title, :body

  validates_presence_of :name
  validates_uniqueness_of :name, :email, :case_sensitive => false

  # ***** IS_TAG *****
  def self.find_for_ldap_oauth(auth)

    puts(">>>>> #{auth.to_json}")
    
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    unless user
      user = User.create(name:auth.info.name,
                         provider:auth.provider,
                         uid:auth.uid,
                         email:auth.info.email,
                         password:Devise.friendly_token[0,20])
    end
    user
  end  

end
