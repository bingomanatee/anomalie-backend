class User < ApplicationRecord
  has_many :dresses

  def has_dress?(name_or_id, features)
    dresses.reduce(false) {|found, dress| found || dress.matches?(name_or_id) && dress.has_features?(features)}
  end
end
