class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :authentication_keys => [:login]

  attr_accessor :login

  has_many :rsvp

  # for bootstrapping your app:
  # if there aren't any admins yet,
  # then anyone can become an admin
  def self.can_become_admin?
    where(:admin => true).count == 0
  end

  def name
    email || nickname || firstname || lastname
  end

  def user_info
    username.blank? ? email : username
  end

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.nickname = auth.info.nickname
      user.username = "#{user.nickname}/#{user.provider}"
      # auth.info.image
      # auth.info.email
    end
  end

#https://github.com/plataformatec/devise/wiki/How-To:-Allow-users-to-sign-in-using-their-username-or-email-address
    def self.find_first_by_auth_conditions(warden_conditions)
      conditions = warden_conditions.dup
      if login = conditions.delete(:login)
        where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
      else
        where(conditions).first
      end
    end

  def self.new_with_session(params, session)
    #raise session.inspect
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"]) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end

  def password_required?
    super && provider.blank?
  end
  def username_required?
    email.blank? || provider.blank?
  end
  def email_required?
    super && username.blank? && provider.blank?
  end
  def update_with_password(params, *options)
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
      super
    end
  end
end
