require 'faker'

AdminUser.create!(email: 'admintrox@yopmail.com', password: 'maxlamenace', password_confirmation: 'maxlamenace') if Rails.env.development?
