class DressTypeBadCombo < ApplicationRecord
  belongs_to :dress_type

  def is_bad?(dress)
    dress.has_features?(combination)
  end
end
