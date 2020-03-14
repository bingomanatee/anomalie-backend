class DressTypeFeature < ApplicationRecord
  belongs_to :dress_type
  validates :name, presence: true
  validates :value, presence: true
end
