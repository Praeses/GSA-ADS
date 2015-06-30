require './src/services/importer_base.rb'
require './src/services/modules/by_count_to_csv.rb'

module Services

  # ***************************************************************************************************
  #   this Importer is used to pull and cache a copy of the drug event counts per location by day
  # ***************************************************************************************************

  class AgeCountImporter < ImporterBase


    def pull
    	data = get_data(url)
      data.extend(Services::ByCountToCsv)
      data.column_name = "AGE"
      data
    end


    def url
      search_string = URI::encode("")
      count_by = "patient.patientonsetage"
      key = "AFArTyRIont4fZLaVXQVgY2kPv8EeIj4BwD24S3R"
      "https://api.fda.gov/drug/event.json?api_key=#{key}&count=#{count_by}#{search_string}"
    end


  end
end
