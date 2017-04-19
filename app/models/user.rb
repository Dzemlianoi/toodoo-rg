# frozen_string_literal: true

class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :rememberable, :trackable, :validatable
  include DeviseTokenAuth::Concerns::User

  has_many :projects, dependent: :destroy
  validates_presence_of :email, :encrypted_password
end
