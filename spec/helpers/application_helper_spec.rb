# coding: UTF-8

require 'spec_helper'

describe ApplicationHelper do
	describe "full_title" do
		it "should include both the page title and the base title" do
			full_title("foo").should == "foo &mdash; #{ I18n.t 'nav.wordhub' }"
		end

		it "should not include an em dash when the page title is not provided or blank" do
			full_title.should_not =~ /\&mdash;/
			full_title("  ").should_not =~ /\&mdash;/
		end
	end

  describe "#copyright_years" do
    subject { copyright_years }
    let(:initial_year) { WhRails::Application.config.initial_year }
    before { Timecop.travel(Time.local(current_year)) }
    after { Timecop.return }
    context "in initial year" do
      let(:current_year) { initial_year }
      it { should eq "#{initial_year}" }
    end
    context "later" do
      let(:current_year) { initial_year + 1 }
      it { should eq "#{initial_year} &mdash; #{current_year}" }
    end
  end

end