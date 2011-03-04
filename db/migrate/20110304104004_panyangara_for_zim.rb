class PanyangaraForZim < ActiveRecord::Migration
  def self.up
    Player.create!(:short_name => 'T Panyangara', :display_name => 'Tinashe Panyangara', :country_id => 14, :role => 'AR')
  end

  def self.down
    panyangara = Player.find_by_short_name('T Panyangara')
    panyangara.destroy
  end
end
