require File.expand_path '../../spec_helper.rb', __FILE__
require './src/services/location_name_importer.rb'

describe "Services::LocationNameImporter" do

  klass = Services::LocationNameImporter

	it "should be defined" do
		expect(klass).not_to be nil
	end

	it "should have an API for pulling location names" do
		subject = klass.new
		subject.pull
		expect(subject.unsaved.size).not_to be 0
	end

end