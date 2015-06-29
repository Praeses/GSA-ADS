
require 'open-uri'
require 'json'
require 'pry'
require 'fileutils'

module Services
  module CountImporterCommon
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

    def get_url count_by, filter_params = {}
      search_string = ""
      
      if filter_params.count > 0
        search_string << "&search="
        param_strings = get_param_strings(filter_params)
        search_string << param_strings.reject(&:empty?).join('+AND+')
      end

      url = URI::encode("https://api.fda.gov/drug/event.json?api_key=AFArTyRIont4fZLaVXQVgY2kPv8EeIj4BwD24S3R&count=" + count_by + search_string)
    end

  end
end