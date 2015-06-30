require './src/services/importer_base.rb'
require './src/services/modules/by_date_to_csv.rb'

module Services

  # ***************************************************************************************************
  # this Importer is used to pull and cache a copy of the drug event counts per location by day
  # ***************************************************************************************************

  class LocationCountsByDateImporter < ImporterBase


    def pull location
      data = {}
      list = []
      list << location
      list.flatten!
      list.each do |l|
        url = url(l)
        get_data(url).each do |result|
          data[result["time"]] = {} unless data[result["time"]]
          data[result["time"]][l] = result["count"]
        end
      end
      data.extend Services::ByDateToCsv
      data
    end


    def url location
      key = "AFArTyRIont4fZLaVXQVgY2kPv8EeIj4BwD24S3R"
      "https://api.fda.gov/drug/event.json?api_key=#{key}&search=primarysource.reportercountry:#{location}&count=receivedate"
    end


  end
end
