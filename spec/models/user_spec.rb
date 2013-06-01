# coding: UTF-8
# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(25)
#  email           :string(100)
#  hashed_password :string(40)
#  salt            :string(40)
#  is_admin        :boolean          default(FALSE)
#  daily_limit     :integer          default(10)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#


require 'spec_helper'

describe User do
#	before { @user = User.new(name: "Иван Иванов",
#														email: "ivan@example.com",
#														password: "secretpassword") }

	let(:user) { FactoryGirl.create(:user) }

	subject { user }

	it { should respond_to(:name) }
	it { should respond_to(:email) }

	it { should be_valid }

	describe "when name is too long" do
		before { user.name = "a" * 26 }
		it { should_not be_valid }
	end

	describe "when email is not present" do
		before { user.email = "" }
		it { should_not be_valid }
	end

	describe "when email format is invalid" do
		it "should be invalid" do
			addresses = %w(user@foo,com user.org user@user@foo.com)
			addresses.each do |invalid_address|
				user.email = invalid_address
				user.should_not be_valid
			end
		end
	end

	describe "when email format is valid" do
		it "should be valid" do
			addresses = %w(UseR@eXampLE.org a_user+ANOther-user@user.user.user)
			addresses.each do |valid_address|
				user.email = valid_address
				user.should be_valid
			end
		end
	end

	describe "when email address is already taken" do
		let(:user_with_same_email) { user.dup }

		subject { user_with_same_email }

		it { should_not be_valid }
	end
end
