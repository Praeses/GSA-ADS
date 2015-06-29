require 'open-uri'
require 'json'
require 'pry'
require 'csv'
require 'fileutils'
require './src/services/count_by_date_importer_common.rb'

module Services

  # *************************************************************************
  # this Importer is used to pull and cache a copy of the drug counts by day
  # *************************************************************************

  class DrugCountsByDateImporter
    include Services::CountByDateImporterCommon

    attr_accessor :unsaved
    FIRST_DAY = Date.parse("2003-2-28")

    def initialize
      @unsaved = {}
      @chems = []
    end

    def pull drug 
      if @unsaved.size <= 0
        list = []
        list << drug
        list.flatten!
        @chems = @chems + list
        list.each do |chem|
          url = "https://api.fda.gov/drug/event.json?api_key=AFArTyRIont4fZLaVXQVgY2kPv8EeIj4BwD24S3R&search=patient.drug.medicinalproduct:#{chem}&count=receivedate"
          get_hash(url, chem)
        end
      end
      true
    end

    def to_csv
      csv = get_csv(@chems, "DRUG")
      csv
    end

  end
end
