class PhoneNumber < ActiveRecord::Base
  belongs_to :person
  
  validates :number,
    presence: true
end
