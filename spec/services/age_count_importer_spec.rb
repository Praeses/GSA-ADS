require File.expand_path '../../spec_helper.rb', __FILE__
require './src/services/age_count_importer.rb'

describe "Services::AgeCountImporter" do

  klass = Services::AgeCountImporter

	it "should be defined" do
		expect(klass).to_not be nil
	end

	it "should have an API for pulling location names" do
		subject = klass.new
		subject.pull
		expect(subject.unsaved.size).to_not be 0
	end

	it "should be able to return data in csv format" do
		subject = klass.new
		subject.pull
		expect(subject.to_csv).to_not be nil
	end

end