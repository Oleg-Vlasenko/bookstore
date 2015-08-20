class Address < ActiveRecord::Base
  belongs_to :country

  validates :address, :phone, :zip_code, :city, :country, :first_name, :last_name, presence: true
end