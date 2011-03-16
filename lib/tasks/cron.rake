task :cron => :environment do
#  if Time.now.in_time_zone('Chennai').hour == 0
    User.all.each do |user|
      if Rails.cache.exists? "#{user.id}_friends"
        puts "removing cache of #{user.name}"
        Rails.cache.delete "#{user.id}_friends"
      end
    end
#  end
end
