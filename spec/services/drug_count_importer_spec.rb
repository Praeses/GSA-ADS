require File.expand_path '../../spec_helper.rb', __FILE__
require './src/services/drug_counts_importer.rb'

describe "Services::DrugCountsImporter" do

  klass = Services::DrugCountsImporter

	it "should be defined" do
		klass.should_not be nil
	end


	# it "should be able to pull the counts for a given drug" do
  #   subject = klass.new
		# subject.pull("sodium")
  #   subject.unsaved.size.should_not be 0
	# end

	it "should have an API for pulling drug counts by date" do
		subject = klass.new
		subject.pull(["sodium", "aspirin", "hydrochloride", "calcium"])
		#subject.pull("sodium")
		subject.unsaved.size.should_not be 0
	end

	# it "should have an API for caching drug counts by date" do
		# subject = klass.new
		# date = Date.parse("2003-2-28")
		# subject.pull_by_date(date)

		#subject.pull_drug_event_page(1, Services::FullEventListImporter::FIRST_DAY)
		#subject.drug_events.size.should_not be 0
	# end

	#it "should be able to determine total entries from meta tag" do
	#	subject = Services::FullEventListImporter.new
	#	subject.server_total.should_not be nil
	#end


	#it "should be able to calculate the number of pages needed to pull down all data" do
	#	subject = Services::FullEventListImporter.new
	#	page = (subject.server_total / 100.0).ceil
	#	subject.pages.should be page
	#end


	#it "should be able to pull two pages of data" do
	#	subject = Services::FullEventListImporter.new
	#	subject.pull_drug_event_page(1)
	#	subject.pull_drug_event_page(2)
	#	subject.drug_events.size.should be 200
	#end


	#it "should should be save the page of data to disk" do
	#	subject = Services::FullEventListImporter.new
	#	#subject.pull_drug_event_page(1)
	#	original_size = `wc -l #{Services::FullEventListImporter::DRUG_DATA_CACHE}`.to_i
	#	subject.pull_drug_event_page(1)
	#	subject.save_pulled_drug_events
	#	new_size = `wc -l #{Services::FullEventListImporter::DRUG_DATA_CACHE}`.to_i
	#	(new_size - original_size).should be 100
	#	#boom goes the dynamite
	#end


	#it "should be able to pull down data for the first day" do
	#	subject = Services::FullEventListImporter.new
	#	subject.pull_drug_event_page(1, Services::FullEventListImporter::FIRST_DAY)
	#	subject.drug_events.size.should_not be 0
	#end



end


