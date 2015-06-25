require 'open-uri'
require 'json'
require 'pry'
require 'csv'
require 'fileutils'

module Services

  class Importer

    def initialize
      @drug_events = []
    end

    PAGE_SIZE = 100.0
    DRUG_DATA_CACHE = './data_cache.csv'
    FIRST_DAY = Date.parse("2003-2-28")

    def pull_drug_events
      wipe_cache
      (FIRST_DAY..Date.today).each do |day|
        begin
          (1..pages(day)).each do |page|
            pull_drug_event_page(page,day)
            save_pulled_drug_events
            puts "Pulled Page: #{page}, day:#{day.to_s}"
          end
        rescue
          puts "ERROR in day:#{day.to_s}"
        end
      end
    end


  	def wipe_cache
      FileUtils.rm(DRUG_DATA_CACHE)
      FileUtils.touch(DRUG_DATA_CACHE)
  	end


  	def pull_drug_event_page page, day=nil
      raw = open(page_url(page, day)).read
      rows = JSON.parse(raw)["results"]
      rows = rows.map{|row| row_view(row) }
      @drug_events = @drug_events + rows
  	end


    def save_pulled_drug_events
      lines = @drug_events.map do |event|
        event.to_csv
      end.join()
      open(DRUG_DATA_CACHE, 'a') { |f| f.puts lines }
      @drug_events = []
    end


  	def drug_events
      @drug_events
  	end


    def server_total day=nil
      @server_total = {} unless @server_total
      return @server_total[day] if @server_total[day]
      meta_url = page_url(1, day)
      data = JSON.parse( open(meta_url).read )
      @server_total[day] = data["meta"]["results"]["total"].to_i
    end


    def pages day=nil
      (server_total(day) / PAGE_SIZE).ceil
    end


    def page_url page, day=nil
      skip = ((page - 1) * PAGE_SIZE).to_i
      key = "AFArTyRIont4fZLaVXQVgY2kPv8EeIj4BwD24S3R"
      if day
        start = day.strftime("%Y%m%d")
        end_day = (day + 1).strftime("%Y%m%d")
        "https://api.fda.gov/drug/event.json?search=receivedate:[#{start}+TO+#{end_day}]&api_key=#{key}&limit=100&skip=#{skip}"
      else
        "https://api.fda.gov/drug/event.json?api_key=#{key}&limit=100&skip=#{skip}"
      end
    end


    def row_view row
      patient = row["patient"]
      age = patient["patientonsetage"].to_i if patient
      drugs = row["patient"]["drug"] if patient
      drugs = drugs || []
      drugs = drugs.map{|d| d["medicinalproduct"]}
      ps = row["primarysource"]
      country = ps["reportercountry"] if ps
      [
        row["safetyreportid"],
        row["receivedate"],
        age,
        drugs,
        country
      ]
    end




  end

end
