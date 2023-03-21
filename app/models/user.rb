class User < ApplicationRecord
  has_many :tools
  has_many :loans
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #validates :firstname, length: { minimum: 2 }, presence: true
  #validates :lastname, presence: true
  #validates :address, presence: true
  #validates :postcode, numericality: true, presence: true
  
end
