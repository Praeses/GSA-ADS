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

    def initialize
      @unsaved = {}
    end


    def pull drug
    end



  end
end
