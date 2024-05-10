class DashboardService

    def self.find_people_counts
        Rails.cache.fetch('people_counts', expires_in: 1.hour) do
            active_count = Person.where(active: true).count
            inactive_count = Person.where(active: false).count
            {active: active_count, inactive: inactive_count}
        end
    end
    
    def self.find_people_active
        Rails.cache.fetch('people_active', expires_in: 1.hour) do
            Person.where(active: true).select(:id)
        end
    end
end