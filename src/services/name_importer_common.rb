
require 'open-uri'
require 'json'
require 'pry'
require 'fileutils'

module Services
  module NameImporterCommon
    def get_hash url
			JSON.parse(open(url).read)["results"].each do |result|
        @unsaved [result["term"]] = result["count"]
			end	
    end

    def get_csv name="NAME"
   	csv = []
    @unsaved.each do |k, value|
      row = [k, value]
      csv << row.to_csv
    end
    csv.sort!
    csv = [name, ", COUNT\n"] + csv
    csv
    end
  end
end