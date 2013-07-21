#encoding: utf-8
module Learnery
  class User < ActiveRecord::Base
    # Include default devise modules. Others available are:
    # :token_authenticatable, :confirmable,
    # :lockable, :timeoutable
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :trackable, :validatable,
           :omniauthable #, :authentication_keys => [:login] #, :nickname, :email

    attr_accessor :login

    has_many :rsvp
    has_many :topics_suggested, class_name: "Topic", foreign_key: "suggested_by_id"
    has_many :topics_presented, class_name: "Topic", foreign_key: "presented_by_id"

    # for bootstrapping your app:
    # if there aren't any admins yet,
    # then anyone can become an admin
    def self.can_become_admin?
      where(:admin => true).count == 0
    end

    def admin?
      return true if self[:admin]
      return true if User.can_become_admin?
      return false
    end

    def name
       nickname || email || firstname || lastname
    end

    def user_info
      nickname.blank? ? email : nickname
    end

    def self.from_omniauth(auth)
      where(auth.slice(:provider, :uid)).first_or_create do |user|
        user.provider = auth.provider
        user.uid = auth.uid
        user.nickname = auth.info.nickname
      end
    end

    # login via nickname or email requires this, see
    # https://github.com/plataformatec/devise/wiki/How-To:-Allow-users-to-sign-in-using-their-username-or-email-address
    def self.find_first_by_auth_conditions(warden_conditions)
      conditions = warden_conditions.dup
      if login = conditions.delete(:login)
        where(conditions).where(["lower(nickname) = :value OR lower(email) = :value", { :value => login.downcase }]).first
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
    def nickname_required?
      email.blank? || provider.blank?
    end
    def email_required?
      super && nickname.blank? && provider.blank?
    end
    def update_with_password(params, *options)
      if encrypted_password.blank?
        update_attributes(params, *options)
      else
        super
      end
    end
  end
end

