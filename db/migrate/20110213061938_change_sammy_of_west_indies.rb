class ChangeSammyOfWestIndies < ActiveRecord::Migration
  def self.up
    sammy = Player.find_by_short_name('DJ Sammy')
    sammy.short_name = 'DJG Sammy'
    sammy.save!

    tikolo = Player.find_by_short_name('S Tikolo')
    tikolo.short_name = 'SO Tikolo'
    tikolo.save!

    odoyo = Player.find_by_short_name('TO Odoyo')
    odoyo.short_name = 'TM Odoyo'
    odoyo.save!

    cheema = Player.find_by_short_name('RA Cheema')
    cheema.short_name = 'Rizwan Cheema'
    cheema.save!

    kumar = Player.find_by_short_name('N Kumar')
    kumar.short_name = 'NR Kumar'
    kumar.save!

    baidwan = Player.find_by_short_name('H Baidwan')
    baidwan.short_name = 'HS Baidwan'
    baidwan.save!

    chohan = Player.find_by_short_name('K Chohan')
    chohan.short_name = 'Khurram Chohan'
    chohan.save!

    tariq = Player.new(:country_id => 3, :short_name => 'Hamza Tariq', :display_name => 'Hamza Tariq', :role => 'WK')
    tariq.save!

    rao = Player.find_by_short_name('WDB Rao')
    rao.short_name = 'WD Balaji Rao'
    rao.save!

    iqbal = Player.find_by_short_name('T Iqbal')
    iqbal.short_name = 'Tamim Iqbal'
    iqbal.save!

    kayes = Player.find_by_short_name('I Kayes')
    kayes.short_name = 'Imrul Kayes'
    kayes.save!

    siddique = Player.find_by_short_name('J Siddique')
    siddique.short_name = 'Junaid Siddique'
    siddique.save!

    rahim = Player.find_by_short_name('M Rahim')
    rahim.short_name = 'Mushfiqur Rahim'
    rahim.save!

    al_hasan = Player.find_by_short_name('S Al Hasan')
    al_hasan.short_name = 'Shakib Al Hasan'
    al_hasan.save!

    ashraful = Player.find_by_short_name('M Ashraful')
    ashraful.short_name = 'Mohammad Ashraful'
    ashraful.save!

    islam = Player.find_by_short_name('N Islam')
    islam.short_name = 'Naeem Islam'
    islam.save!

    mahmudullah = Player.find_by_short_name('M Mahmudullah')
    mahmudullah.short_name = 'Mahmudullah'
    mahmudullah.save!

    razzak = Player.find_by_short_name('A Razzak')
    razzak.short_name = 'Abdur Razzak'
    razzak.save!

    islam_s = Player.find_by_short_name('S Islam')
    islam_s.short_name = 'Shafiul Islam'
    islam_s.save!

    hossain = Player.find_by_short_name('R Hossain')
    hossain.short_name = 'Rubel Hossain'
    hossain.save!

    nafees = Player.find_by_short_name('S Nafees')
    nafees.short_name = 'Shahriar Nafees'
    nafees.save!

    hossain_n = Player.find_by_short_name('N Hossain')
    hossain_n.short_name = 'Nazmul Hossain'
    hossain_n.save!

    hasan = Player.find_by_short_name('R Hasan')
    hasan.short_name = 'Raqibul Hasan'
    hasan.save!

    shuvo = Player.find_by_short_name('S Shuvo')
    shuvo.short_name = 'Suhrawadi Shuvo'
    shuvo.save!

    raja = Player.find_by_short_name('A Raja')
    raja.short_name = 'Adeel Raja'
    raja.save!

    bukhari = Player.find_by_short_name('M Bukhari')
    bukhari.short_name = 'Mudassar Bukhari'
    bukhari.save!

    buurman = Player.find_by_short_name('A Buurman')
    buurman.short_name = 'AF Buurman'
    buurman.save!

    tahir = Player.find_by_short_name('MI Tahir')
    tahir.short_name = 'Imran Tahir'
    tahir.save!
  end

  def self.down
    tahir = Player.find_by_short_name('Imran Tahir')
    tahir.short_name = 'MI Tahir'
    tahir.save!

    raja = Player.find_by_short_name('Adeel Raja')
    raja.short_name = 'A Raja'
    raja.save!

    bukhari = Player.find_by_short_name('Mudassar Bukhari')
    bukhari.short_name = 'M Bukhari'
    bukhari.save!

    buurman = Player.find_by_short_name('AF Buurman')
    buurman.short_name = 'A Buurman'
    buurman.save!

    iqbal = Player.find_by_short_name('Tamim Iqbal')
    iqbal.short_name = 'T Iqbal'
    iqbal.save!

    kayes = Player.find_by_short_name('Imrul Kayes')
    kayes.short_name = 'I Kayes'
    kayes.save!

    siddique = Player.find_by_short_name('Junaid Siddique')
    siddique.short_name = 'J Siddique'
    siddique.save!

    rahim = Player.find_by_short_name('Mushfiqur Rahim')
    rahim.short_name = 'M Rahim'
    rahim.save!

    al_hasan = Player.find_by_short_name('Shakib Al Hasan')
    al_hasan.short_name = 'S Al Hasan'
    al_hasan.save!

    ashraful = Player.find_by_short_name('Mohammad Ashraful')
    ashraful.short_name = 'M Ashraful'
    ashraful.save!

    islam = Player.find_by_short_name('Naeem Islam')
    islam.short_name = 'N Islam'
    islam.save!

    mahmudullah = Player.find_by_short_name('Mahmudullah')
    mahmudullah.short_name = 'M Mahmudullah'
    mahmudullah.save!

    razzak = Player.find_by_short_name('Abdur Razzak')
    razzak.short_name = 'A Razzak'
    razzak.save!

    islam_s = Player.find_by_short_name('Shafiul Islam')
    islam_s.short_name = 'S Islam'
    islam_s.save!

    hossain = Player.find_by_short_name('Rubel Hossain')
    hossain.short_name = 'R Hossain'
    hossain.save!

    nafees = Player.find_by_short_name('Shahriar Nafees')
    nafees.short_name = 'S Nafees'
    nafees.save!

    shuvo = Player.find_by_short_name('Suhrawadi Shuvo')
    shuvo.short_name = 'S Shuvo'
    shuvo.save!

    hasan = Player.find_by_short_name('Raqibul Hasan')
    hasan.short_name = 'R Hasan'
    hasan.save!

    hossain_n = Player.find_by_short_name('Nazmul Hossain')
    hossain_n.short_name = 'N Hossain'
    hossain_n.save!

    rao = Player.find_by_short_name('WD Balaji Rao')
    rao.short_name = 'WDB Rao'
    rao.save!

    tariq = Player.find_by_short_name('Hamza Tariq')
    tariq.delete

    chohan = Player.find_by_short_name('Khurram Chohan')
    chohan.short_name = 'K Chohan'
    chohan.save!

    baidwan = Player.find_by_short_name('HS Baidwan')
    baidwan.short_name = 'H Baidwan'
    baidwan.save!

    kumar = Player.find_by_short_name('NR Kumar')
    kumar.short_name = 'N Kumar'
    kumar.save!

    cheema = Player.find_by_short_name('Rizwan Cheema')
    cheema.short_name = 'RA Cheema'
    cheema.save!

    odoyo = Player.find_by_short_name('TM Odoyo')
    odoyo.short_name = 'TO Odoyo'
    odoyo.save!

    tikolo = Player.find_by_short_name('SO Tikolo')
    tikolo.short_name = 'S Tikolo'
    tikolo.save!

    sammy = Player.find_by_short_name('DJG Sammy')
    sammy.short_name = 'DJ Sammy'
    sammy.save!
  end
end
