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
	let(:user) { create(:user) }

	subject { user }

	it { should respond_to(:name) }
	it { should respond_to(:email) }

	it { should be_valid }

	it "is invalid when name is too long" do
		user.name = "a" * 26
		expect(user).to_not be_valid
	end

	it "is invalid when email is not present" do
		user.email = ""
		expect(user).to_not be_valid
	end

	it "is invalid when email format is invalid" do
		addresses = %w(user@foo,com user.org user@user@foo.com)
		addresses.each do |invalid_address|
			user.email = invalid_address
			expect(user).to_not be_valid
		end
	end


	it "is valid when email format is valid" do
		addresses = %w(UseR@eXampLE.org a_user+ANOther-user@user.user.user)
		addresses.each do |valid_address|
			user.email = valid_address
			expect(user).to be_valid
		end
	end

	it "is invalid when email address is already taken" do
		user_with_same_email = user.dup
		expect(user_with_same_email).to_not be_valid
	end

	context "stats" do
		describe "successful repetitions percentage should be 0 if no repetitions have been run today" do
			subject { user.stats_for_period(1.day)[:successful_repetitions_percentage] }

			it { should be_zero }
		end
	end
end
