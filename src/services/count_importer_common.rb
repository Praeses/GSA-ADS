require 'open-uri'
require 'json'
require 'pry'
require 'fileutils'

module Services
  module CountImporterCommon
    def get_hash url, chem
        JSON.parse(open(url).read)["results"].each do |result|
        @unsaved[result["time"]] = {} unless @unsaved[result["time"]]
        @unsaved[result["time"]][chem] = result["count"]
      end
      true
    end

    def get_csv list, name="NAME"
      csv = []
      if @unsaved
        @unsaved.each do |k,values|
          row = [k]
          list.each do |chem|
            row << ( values[chem] || "0" )
          end
          
          csv << row.to_csv

        end
      end
      csv.sort!
      csv = [name + ',' + list.join(",") + "\n"] + csv
      csv.join('')
    end
  end
end