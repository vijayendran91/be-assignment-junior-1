class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
  attr_accessor :name, :email, :password, :password_confirmation
  has_secure_password
  def change
    create_table :users do |t|
      t.string "email"
      t.string "mobile"
      t.string "password_digest"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end
  end
end
