
require 'open-uri'
require 'json'
require 'pry'
require 'fileutils'

module Services
  module NameImporterCommon
    def get_hash url, value
		JSON.parse(open(url).read)["results"].each do |result|
	        @unsaved << result["term"]
		end	
    end

    def get_csv name="NAME"
      csv = []
	  @unsaved.each do |location|
	    row = [location]
	    csv << row.to_csv
	  end
	  csv.sort!
	  csv = [name+"\n"] + csv
	  csv
    end
  end
end