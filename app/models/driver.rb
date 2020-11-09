class Driver < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :phone_number, presence: true, length: { is: 10 }, uniqueness: true
  validates :license_number, presence: true, uniqueness: true
  validates :car_number, presence: true, uniqueness: true
  validates :latitude, presence: true
  validates :longitude, presence: true

end
