class Person < ActiveRecord::Base
  has_many :phone_numbers
  has_many :email_addresses
  
  validates :first_name,
    presence: true
  validates :last_name,
    presence: true
end
