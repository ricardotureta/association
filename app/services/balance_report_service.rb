require 'csv'

class BalanceReportService
  def self.generate_report
    people = Person.order(:name)
    csv_data = CSV.generate do |csv|
      csv << ['Nome', 'Saldo']
      people.each do |person|
        csv << [person.name, format('%.2f', person.amount)]
      end
    end
    csv_data
  end
end