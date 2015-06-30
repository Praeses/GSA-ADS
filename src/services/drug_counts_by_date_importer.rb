require './src/services/importer_base.rb'
require './src/services/modules/by_date_to_csv.rb'

module Services

  # *************************************************************************
  # this Importer is used to pull and cache a copy of the drug counts by day
  # *************************************************************************

  class DrugCountsByDateImporter < ImporterBase


    def pull drug
      data = {}
      list = []
      list << drug
      list.flatten!
      list.each do |d|
        url = url(d)
        get_data(url).each do |result|
          data[result["time"]] = {} unless data[result["time"]]
          data[result["time"]][d] = result["count"]
        end
      end
      data.extend Services::ByDateToCsv
      data
    end


    def url drug
      key = "AFArTyRIont4fZLaVXQVgY2kPv8EeIj4BwD24S3R"
      "https://api.fda.gov/drug/event.json?api_key=#{key}&search=patient.drug.medicinalproduct:#{drug}&count=receivedate"
    end


  end
end
