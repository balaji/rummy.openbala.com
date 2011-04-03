class MigrateBallsFromData < ActiveRecord::Migration
  def self.up
    matches = Match.find(:all, :conditions => ['status = ?', 'finished'])
    matches.each do |match|
      File.new("#{RAILS_ROOT}/db/data/batsmen#{match.id}.txt", 'r').each_line("\n") do |row|
        columns = row.split("\t")
        score_card = BattingScoreCard.find_by_match_id_and_player_id(match.id, Player.find_by_short_name(columns[0].strip).id)
        if score_card
          score_card.balls = columns[4]
          score_card.save!
        end
      end
    end
  end

  def self.down
  end
end
