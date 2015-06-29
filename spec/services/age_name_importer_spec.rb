require File.expand_path '../../spec_helper.rb', __FILE__
require './src/services/age_name_importer.rb'

describe "Services::AgeNameImporter" do

  klass = Services::LocationNameImporter

	it "should be defined" do
		klass.should_not be nil
	end

	it "should have an API for pulling location names" do
		subject = klass.new
		subject.pull
		subject.unsaved.size.should_not be 0
	end

end