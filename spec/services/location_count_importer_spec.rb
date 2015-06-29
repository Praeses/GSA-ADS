require File.expand_path '../../spec_helper.rb', __FILE__
require './src/services/location_count_importer.rb'

describe "Services::LocationCountImporter" do

  klass = Services::LocationCountImporter

	it "should be defined" do
		expect(klass).not_to be nil
	end

	it "should have an API for pulling location names" do
		subject = klass.new
		subject.pull
		expect(subject.unsaved.size).not_to be 0
	end

end