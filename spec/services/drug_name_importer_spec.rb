require File.expand_path '../../spec_helper.rb', __FILE__
require './src/services/drug_name_importer.rb'

describe "Services::DrugNameImporter" do

  klass = Services::DrugNameImporter

	it "should be defined" do
		expect(klass).not_to be nil
	end

	it "should have an API for pulling drug names" do
		subject = klass.new
		subject.pull
		expect(subject.unsaved.size).not_to be 0
	end

end