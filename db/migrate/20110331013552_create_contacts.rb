class CreateContacts < ActiveRecord::Migration
  def self.up
    create_table :contacts do |t|
      t.integer    "attachable_id"
      t.string     "attachable_type"
      t.string     "address1"
      t.string     "address2"
      t.string     "city"
      t.references :state
      t.string     "zip",          :limit => 20
      t.references :country
      t.string     "mobile_phone", :limit => 20
      t.string     "home_phone",   :limit => 20
      t.string     "work_phone",   :limit => 20
      t.string     "website"
      t.string     "lat",          :limit => 20
      t.string     "long",         :limit => 20

      t.timestamps
    end
   
    add_index("contacts", "country_id")
    add_index("contacts", "state_id")

  end

  def self.down
    drop_table :contacts
  end
end
