class FeedbackFromWarmUp3 < ActiveRecord::Migration
  def self.up
    hafeez = Player.find_by_short_name('M Hafeez')
    hafeez.short_name = 'Mohammad Hafeez'
    hafeez.save!

    shehzad = Player.find_by_short_name('A Shehzad')
    shehzad.short_name = 'Ahmed Shehzad'
    shehzad.save!

    k_akmal = Player.find_by_short_name('K Akmal')
    k_akmal.short_name = 'Kamran Akmal'
    k_akmal.save!

    y_khan = Player.find_by_short_name('Y Khan')
    y_khan.short_name = 'Younis Khan'
    y_khan.save!

    misbah = Player.find_by_short_name('M ul-Haq')
    misbah.short_name = 'Misbah-ul-Haq'
    misbah.save!

    afridi = Player.find_by_short_name('S Afridi')
    afridi.short_name = 'Shahid Afridi'
    afridi.save!

    razzaq = Player.find_by_short_name('A Razzaq')
    razzaq.short_name = 'Abdul Razzaq'
    razzaq.save!

    u_akmal = Player.find_by_short_name('U Akmal')
    u_akmal.short_name = 'Umar Akmal'
    u_akmal.save!

    riaz = Player.find_by_short_name('W Riaz')
    riaz.short_name = 'Wahab Riaz'
    riaz.save!

    rehman = Player.find_by_short_name('A Rehman')
    rehman.short_name = 'Abdur Rehman'
    rehman.save!

    gul = Player.find_by_short_name('U Gul')
    gul.short_name = 'Umar Gul'
    gul.save!

    ajmal = Player.find_by_short_name('S Ajmal')
    ajmal.short_name = 'Saeed Ajmal'
    ajmal.save!

    akhtar = Player.find_by_short_name('S Akhtar')
    akhtar.short_name = 'Shoaib Akhtar'
    akhtar.save!

    shafiq = Player.find_by_short_name('A Shafiq')
    shafiq.short_name = 'Asad Shafiq'
    shafiq.save!

    Player.create!(:display_name => 'Junaid Khan', :short_name => 'Junaid Khan', :country_id => 10, :role => 'BWL');

    tanvir = Player.find_by_short_name('S Tanvir')
    tanvir.destroy
  end

  def self.down
    hafeez = Player.find_by_short_name('Mohammad Hafeez')
    hafeez.short_name = 'M Hafeez'
    hafeez.save!

    shehzad = Player.find_by_short_name('Ahmed Shehzad')
    shehzad.short_name = 'A Shehzad'
    shehzad.save!

    k_akmal = Player.find_by_short_name('Kamran Akmal')
    k_akmal.short_name = 'K Akmal'
    k_akmal.save!

    y_khan = Player.find_by_short_name('Younis Khan')
    y_khan.short_name = 'Y Khan'
    y_khan.save!

    misbah = Player.find_by_short_name('Misbah-ul-Haq')
    misbah.short_name = 'M ul-Haq'
    misbah.save!

    afridi = Player.find_by_short_name('Shahid Afridi')
    afridi.short_name = 'S Afridi'
    afridi.save!

    razzaq = Player.find_by_short_name('Abdul Razzaq')
    razzaq.short_name = 'A Razzaq'
    razzaq.save!

    u_akmal = Player.find_by_short_name('Umar Akmal')
    u_akmal.short_name = 'U Akmal'
    u_akmal.save!

    riaz = Player.find_by_short_name('Wahab Riaz')
    riaz.short_name = 'W Riaz'
    riaz.save!

    rehman = Player.find_by_short_name('Abdur Rehman')
    rehman.short_name = 'A Rehman'
    rehman.save!

    gul = Player.find_by_short_name('Umar Gul')
    gul.short_name = 'U Gul'
    gul.save!

    ajmal = Player.find_by_short_name('Saeed Ajmal')
    ajmal.short_name = 'S Ajmal'
    ajmal.save!

    akhtar = Player.find_by_short_name('Shoaib Akhtar')
    akhtar.short_name = 'S Akhtar'
    akhtar.save!

    shafiq = Player.find_by_short_name('Asad Shafiq')
    shafiq.short_name = 'A Shafiq'
    shafiq.save!

    Player.create!(:display_name => 'Sohail Tanvir', :short_name => 'S Tanvir', :country_id => 10, :role => 'BWL');

    junaid = Player.find_by_short_name('Junaid Khan')
    junaid.destroy

  end
end
