ActiveRecord::Schema.define(version: 20170402165951) do

  enable_extension "plpgsql"

  create_table "comments", force: :cascade do |t|
    t.string   "comment_text"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "task_id"
    t.integer  "user_id"
    t.index ["task_id"], name: "index_comments_on_task_id", using: :btree
    t.index ["user_id"], name: "index_comments_on_user_id", using: :btree
  end

  create_table "projects", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
    t.index ["user_id"], name: "index_projects_on_user_id", using: :btree
  end

  create_table "tasks", force: :cascade do |t|
    t.string   "title"
    t.datetime "deadline"
    t.boolean  "completed"
    t.integer  "priorite"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "project_id"
    t.index ["project_id"], name: "index_tasks_on_project_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "provider",            default: "email", null: false
    t.string   "uid",                 default: "",      null: false
    t.string   "encrypted_password",  default: "",      null: false
    t.string   "email"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",       default: 0,       null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.json     "tokens"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true, using: :btree
  end

  add_foreign_key "comments", "tasks"
  add_foreign_key "comments", "users"
  add_foreign_key "projects", "users"
  add_foreign_key "tasks", "projects"
end
