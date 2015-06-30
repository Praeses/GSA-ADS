require 'csv'

module Services
  module ByDateToCsv

    def to_csv
      columns = self.map{ |k,v| v.keys }.flatten.uniq
      rows = self.map do|d,hash|
        row = [d]
        columns.each { |col| row << ( hash[col] || "0" ) }
        row.to_csv
      end
      rows.sort!
      rows = ['date,' + columns.join(",") + "\n"] + rows
      rows.join('')
    end

  end
end
