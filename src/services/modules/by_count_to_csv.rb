require 'csv'

module Services
  module ByCountToCsv

    def column_name= value
      @column_name = value
    end

    def to_csv
      csv = self.map do |row|
        row = row.to_a.flatten
        k = row[1]
        k = ('%02i' % row[1]) if k.is_a? Numeric
        "#{k}, #{row[3]}"
      end
      csv.sort!
      csv = ["#{@column_name}, COUNT"] + csv
      csv.join("\n")
    end


  end
end
