require File.expand_path '../../spec_helper.rb', __FILE__
require './src/services/drug_name_importer.rb'

describe "Services::DrugNameImporter" do

  klass = Services::DrugNameImporter

	it "should be defined" do
		klass.should_not be nil
	end

	it "should have an API for pulling drug names" do
		subject = klass.new
		subject.pull
		subject.unsaved.size.should_not be 0
	end

end