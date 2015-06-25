require 'open-uri'
require 'json'
require 'pry'
require 'csv'
require 'fileutils'

module Services

  # *************************************************************************
  # this Importer is used to pull and cache a copy of the drug counts by day
  # *************************************************************************

  class DrugCountsImporter

    attr_accessor :unsaved
    FIRST_DAY = Date.parse("2003-2-28")

    def initialize
      @unsaved = {}
      @chems = []
    end

    def pull drug #(date_begin = FIRST_DAY, date_end = Date.today)
      #list = ['sodium', 'aspirin', 'hydrochloride', 'calcium']
      if @unsaved.size <= 0
        list = []
        list << drug
        list.flatten!
        @chems = @chems + list

        list.each do |chem|
          url = "https://api.fda.gov/drug/event.json?api_key=AFArTyRIont4fZLaVXQVgY2kPv8EeIj4BwD24S3R&search=patient.drug.medicinalproduct:#{chem}&count=receivedate"
          #url = "https://api.fda.gov/drug/event.json?api_key=AFArTyRIont4fZLaVXQVgY2kPv8EeIj4BwD24S3R&search=receivedate:[20101225+TO+20111225]+AND+patient.drug.medicinalproduct:#{chem}&count=receivedate"
          get_data(url).each do |result|
            @unsaved[result["time"]] = {} unless @unsaved[result["time"]]
            @unsaved[result["time"]][chem] = result["count"]
          end
        end
      end
      true
    end

    def get_data url
      JSON.parse(open(url).read)["results"]
    end

    def to_csv
      csv = []
     
      @unsaved.each do |k,values|
        row = [k]
        @chems.each do |chem|
          row << ( values[chem] || "0" )
        end
        
        csv << row.to_csv

      end
      csv.sort!
      csv = ["date," + @chems.join(",") + "\n"] + csv
      csv.join('')
    end

  end
end
