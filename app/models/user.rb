class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :rememberable, :trackable, :validatable, :omniauthable
  include DeviseTokenAuth::Concerns::User

  has_many :projects, dependent: :destroy
  has_many :comments, dependent: :destroy
end
