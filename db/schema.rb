# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20111019233519) do

  create_table "academic_degrees", :force => true do |t|
    t.integer  "student_id"
    t.string   "year",           :limit => 4
    t.string   "name"
    t.integer  "institution_id"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "academic_degrees", ["institution_id"], :name => "index_academic_degrees_on_institution_id"
  add_index "academic_degrees", ["student_id"], :name => "index_academic_degrees_on_student_id"

  create_table "advances", :force => true do |t|
    t.integer  "student_id"
    t.text     "title"
    t.datetime "advance_date"
    t.integer  "tutor1"
    t.integer  "tutor2"
    t.integer  "tutor3"
    t.integer  "tutor4"
    t.integer  "tutor5"
    t.string   "status",       :limit => 1
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "advances", ["student_id"], :name => "index_advances_on_student_id"
  add_index "advances", ["tutor1"], :name => "index_advances_on_tutor1"
  add_index "advances", ["tutor2"], :name => "index_advances_on_tutor2"
  add_index "advances", ["tutor3"], :name => "index_advances_on_tutor3"
  add_index "advances", ["tutor4"], :name => "index_advances_on_tutor4"
  add_index "advances", ["tutor5"], :name => "index_advances_on_tutor5"

  create_table "campus", :force => true do |t|
    t.string   "short_name", :limit => 20
    t.string   "name"
    t.integer  "contact_id"
    t.string   "image"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "classrooms", :force => true do |t|
    t.string   "code"
    t.string   "name"
    t.integer  "room_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contacts", :force => true do |t|
    t.integer  "attachable_id"
    t.string   "attachable_type"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.integer  "state_id"
    t.string   "zip",             :limit => 20
    t.integer  "country_id"
    t.string   "mobile_phone",    :limit => 20
    t.string   "home_phone",      :limit => 20
    t.string   "work_phone",      :limit => 20
    t.string   "website"
    t.string   "lat",             :limit => 20
    t.string   "long",            :limit => 20
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "contacts", ["country_id"], :name => "index_contacts_on_country_id"
  add_index "contacts", ["state_id"], :name => "index_contacts_on_state_id"

  create_table "countries", :force => true do |t|
    t.string   "name"
    t.string   "code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "courses", :force => true do |t|
    t.integer  "program_id"
    t.string   "code",          :limit => 10
    t.string   "name"
    t.decimal  "lecture_hours",               :precision => 8, :scale => 2
    t.decimal  "lab_hours",                   :precision => 8, :scale => 2
    t.decimal  "credits",                     :precision => 8, :scale => 2
    t.text     "description"
    t.integer  "term",                                                      :default => 1
    t.integer  "prereq1"
    t.integer  "prereq2"
    t.integer  "prereq3"
    t.integer  "coreq1"
    t.integer  "coreq2"
    t.integer  "coreq3"
    t.text     "notes"
    t.integer  "status",                                                    :default => 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "courses", ["program_id"], :name => "index_courses_on_program_id"

  create_table "departments", :force => true do |t|
    t.string   "name",        :limit => 100, :null => false
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "institutions", :force => true do |t|
    t.string   "short_name", :limit => 20
    t.string   "name"
    t.integer  "contact_id"
    t.string   "image"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "internship_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "internships", :force => true do |t|
    t.integer  "internship_type_id"
    t.string   "first_name",         :limit => 50,                  :null => false
    t.string   "last_name",          :limit => 50,                  :null => false
    t.string   "gender",             :limit => 1
    t.date     "date_of_birth"
    t.date     "start_date"
    t.date     "end_date"
    t.string   "location"
    t.string   "email"
    t.integer  "institution_id"
    t.integer  "contact_id"
    t.integer  "staff_id"
    t.string   "thesis_title"
    t.text     "activities"
    t.string   "status",             :limit => 20, :default => "0"
    t.string   "image"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "internships", ["contact_id"], :name => "index_internships_on_contact_id"
  add_index "internships", ["institution_id"], :name => "index_internships_on_institution_id"
  add_index "internships", ["internship_type_id"], :name => "index_internships_on_internship_type_id"
  add_index "internships", ["staff_id"], :name => "index_internships_on_staff_id"

  create_table "programs", :force => true do |t|
    t.string   "name"
    t.string   "level",          :limit => 20
    t.string   "prefix",         :limit => 5
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "terms_duration"
    t.integer  "terms_qty"
  end

  create_table "scholarship_categories", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "scholarship_types", :force => true do |t|
    t.integer  "scholarship_category_id"
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "scholarship_types", ["scholarship_category_id"], :name => "index_scholarship_types_on_scholarship_category_id"

  create_table "scholarships", :force => true do |t|
    t.integer  "student_id"
    t.date     "start_date"
    t.date     "end_date"
    t.string   "status"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "scholarship_type_id"
    t.string   "amount"
    t.integer  "institution_id"
    t.integer  "department_id"
    t.string   "other_department"
  end

  add_index "scholarships", ["student_id"], :name => "index_scholarships_on_student_id"

  create_table "staffs", :force => true do |t|
    t.integer  "employee_number"
    t.string   "title",           :limit => 10
    t.string   "first_name",      :limit => 50,                  :null => false
    t.string   "last_name",       :limit => 50,                  :null => false
    t.string   "gender",          :limit => 1
    t.date     "date_of_birth"
    t.string   "location"
    t.string   "email"
    t.integer  "institution_id"
    t.integer  "contact_id"
    t.string   "cvu"
    t.string   "sni",             :limit => 20
    t.string   "status",          :limit => 20, :default => "0"
    t.string   "image"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stances", :force => true do |t|
    t.integer  "student_id"
    t.integer  "institution_id"
    t.date     "start_date"
    t.date     "end_date"
    t.string   "agreement"
    t.string   "status"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "stances", ["institution_id"], :name => "index_stances_on_institution_id"
  add_index "stances", ["student_id"], :name => "index_stances_on_student_id"

  create_table "states", :force => true do |t|
    t.string   "name"
    t.string   "code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "student_files", :force => true do |t|
    t.integer  "student_id"
    t.string   "description"
    t.string   "file"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "student_files", ["student_id"], :name => "index_student_files_on_student_id"

  create_table "students", :force => true do |t|
    t.integer  "program_id"
    t.string   "card",                 :limit => 20
    t.string   "previous_card",        :limit => 20
    t.integer  "consecutive"
    t.string   "first_name",           :limit => 50,                :null => false
    t.string   "last_name",            :limit => 50,                :null => false
    t.string   "gender",               :limit => 1
    t.date     "date_of_birth"
    t.string   "city"
    t.integer  "state_id"
    t.integer  "country_id"
    t.string   "email"
    t.integer  "previous_institution"
    t.string   "previous_degree_type"
    t.string   "previous_degree_desc"
    t.date     "previous_degree_date"
    t.integer  "contact_id"
    t.date     "start_date"
    t.date     "end_date"
    t.date     "graduation_date"
    t.date     "inactive_date"
    t.integer  "supervisor"
    t.integer  "co_supervisor"
    t.integer  "department_id"
    t.string   "curp"
    t.string   "ife"
    t.string   "cvu"
    t.string   "location"
    t.string   "ssn"
    t.string   "blood_type"
    t.string   "accident_contact"
    t.string   "accident_phone"
    t.string   "passport"
    t.string   "image"
    t.integer  "status",                             :default => 1
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "campus_id"
  end

  add_index "students", ["campus_id"], :name => "index_students_on_campus_id"
  add_index "students", ["card"], :name => "index_students_on_card"
  add_index "students", ["co_supervisor"], :name => "index_students_on_co_supervisor"
  add_index "students", ["contact_id"], :name => "index_students_on_contact_id"
  add_index "students", ["country_id"], :name => "index_students_on_country_id"
  add_index "students", ["department_id"], :name => "index_students_on_department_id"
  add_index "students", ["program_id"], :name => "index_students_on_program_id"
  add_index "students", ["supervisor"], :name => "index_students_on_supervisor"

  create_table "term_course_schedules", :force => true do |t|
    t.integer  "term_course_id"
    t.integer  "day"
    t.time     "start_hour"
    t.time     "end_hour"
    t.integer  "classroom_id"
    t.integer  "staff_id"
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "class_type"
    t.integer  "status",         :default => 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "term_course_schedules", ["classroom_id"], :name => "index_term_course_schedules_on_classroom_id"
  add_index "term_course_schedules", ["staff_id"], :name => "index_term_course_schedules_on_staff_id"
  add_index "term_course_schedules", ["term_course_id"], :name => "index_term_course_schedules_on_term_course_id"

  create_table "term_course_students", :force => true do |t|
    t.integer  "term_course_id"
    t.integer  "term_student_id"
    t.integer  "grade"
    t.integer  "status",          :default => 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "term_course_students", ["term_course_id"], :name => "index_term_course_students_on_term_course_id"
  add_index "term_course_students", ["term_student_id"], :name => "index_term_course_students_on_term_student_id"

  create_table "term_courses", :force => true do |t|
    t.integer  "term_id"
    t.integer  "course_id"
    t.integer  "status",     :default => 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "term_courses", ["course_id"], :name => "index_term_courses_on_course_id"
  add_index "term_courses", ["term_id"], :name => "index_term_courses_on_term_id"

  create_table "term_students", :force => true do |t|
    t.integer  "term_id"
    t.integer  "student_id"
    t.string   "notes"
    t.integer  "status",     :default => 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "term_students", ["student_id"], :name => "index_term_students_on_student_id"
  add_index "term_students", ["term_id"], :name => "index_term_students_on_term_id"

  create_table "terms", :force => true do |t|
    t.integer  "program_id"
    t.string   "code",       :limit => 10
    t.string   "name",       :limit => 80
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "status",                   :default => 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "terms", ["program_id"], :name => "index_terms_on_program_id"

  create_table "theses", :force => true do |t|
    t.integer  "student_id"
    t.string   "number",       :limit => 20
    t.integer  "consecutive"
    t.text     "title"
    t.text     "abstract"
    t.datetime "defence_date"
    t.integer  "examiner1"
    t.integer  "examiner2"
    t.integer  "examiner3"
    t.integer  "examiner4"
    t.integer  "examiner5"
    t.string   "status",       :limit => 1
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "theses", ["examiner1"], :name => "index_theses_on_examiner1"
  add_index "theses", ["examiner2"], :name => "index_theses_on_examiner2"
  add_index "theses", ["examiner3"], :name => "index_theses_on_examiner3"
  add_index "theses", ["examiner4"], :name => "index_theses_on_examiner4"
  add_index "theses", ["examiner5"], :name => "index_theses_on_examiner5"
  add_index "theses", ["student_id"], :name => "index_theses_on_student_id"

  create_table "users", :force => true do |t|
    t.string   "email"
    t.integer  "access",     :default => 2
    t.integer  "status",     :default => 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
