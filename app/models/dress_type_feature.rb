class DressTypeFeature < ApplicationRecord
  belongs_to :dress_type
  validates :name, presence: true
  validates :value, presence: true

  def self.valid_name?(name)
    name.is_a?(String) && name.size
  end

  def self.valid_option?(option)
    option.is_a?(String) && option.size
  end
end
