database = Gemika::Database.new
database.connect


database.rewrite_schema! do

  create_table :samples do |t|
    t.string :name
    t.integer :value
  end

  create_table :records do |t|
    t.string :persisted_string
    t.integer :persisted_integer
    t.datetime :persisted_time
    t.date :persisted_date
    t.boolean :persisted_boolean
  end

  create_table :children do |t|
    t.integer :record_id
    t.boolean :nice
  end

  create_table :uuid_records, id: false do |t|
    t.string :id, primary_key: true, limit: 100
    t.string :persisted_string
  end

  create_table :sti_records do |t|
    t.string :persisted_string
    t.string :type
  end

  create_table :other_records do |t|
    t.string :other_string
  end

end
