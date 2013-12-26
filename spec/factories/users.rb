# == Schema Information
#
# Table name: users
#
#  id                    :integer          not null, primary key
#  name                  :string(25)
#  email                 :string(100)
#  hashed_password       :string(40)
#  salt                  :string(40)
#  is_admin              :boolean          default(FALSE)
#  daily_limit           :integer          default(10)
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  interface_language_cd :integer          default(0)
#


require 'faker'

FactoryGirl.define do
  factory :user do
    name { Faker::Name.name.truncate(25) }
    email { Faker::Internet.email }
    password "secretpassword"
  end
end
