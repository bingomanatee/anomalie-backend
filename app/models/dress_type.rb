class DressType < ApplicationRecord
  has_many :dress_type_features

  def feature_list
    out = {}
    dress_type_features.each do |feature|
      if out.has_key? feature.name
        out[feature.name] << feature.value
      else
        out[feature.name] = [feature.value]
      end
    end

    return out
  end
end
