class User < ApplicationRecord

  has_many :tools
  has_many :loans
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  
         
         after_create :welcome_send

         def welcome_send
           UserMailer.welcome_email(self).deliver_now
         end



end
