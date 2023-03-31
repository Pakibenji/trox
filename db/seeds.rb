# frozen_string_literal: true

require 'faker'

if Rails.env.development?
  AdminUser.create!(email:ENV['ADMIN_MAIL'], password: ENV['ADMIN_PASSWORD'],
    password_confirmation: ENV['ADMIN_PASSWORD'])
end
