namespace :ipl do
  task :bot, :needs => :environment do
    doc = Nokogiri::HTML(open("http://www.espncricinfo.com/ipl-chennai/content/squad/495836.html"))
    doc.xpath("//p[@class='ciHOFplayer']").collect do |row|
      e = row.at_xpath('a/text()')
      e1 = row.at_xpath('a/@href')
      p "#{e}  #{e1}"
      doc2 = Nokogiri::HTML(open("http://www.espncricinfo.com#{e1}"))
      doc2.xpath("//p[@class='ciPlayerinformationtxt']").collect do |row1|
        if(row1.at_xpath('b/text()').to_s == 'Full name')
          puts row1.at_xpath('span/text()')
          break
        end
      end
    end
  end
end
