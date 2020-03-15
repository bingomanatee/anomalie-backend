class DressType < ApplicationRecord
  has_many :dress_type_features
  has_many :dress_type_bad_combos

  def matches?(name_or_id)
    if (name_or_id.is_a? String)
      name_or_id.downcase == name.downcase
    else
      name_or_id.is_a? Numeric
    end
  end

  def add_features(features)
    if (!features.is_a? Array)
      return
    end

    features.each do |feature|
      if DressTypeFeature.valid_name?(feature["name"]) && feature["options"] && feature["options"].is_a?(Array)
        feature["options"].each do |option|
          if DressTypeFeature.valid_option?(option)
            add_feature_value(feature["name"], option)
          end
        end
      end
    end
  end

  def feature_list
    dress_type_features.reduce({}) do |out, feature|
      if out.has_key? feature.name
        out[feature.name] << feature.value
      else
        out[feature.name] = Set[feature.value]
      end
      out
    end
  end

  def has_feature_value?(name, value)
    DressTypeFeature.where(dress_type_id: id, name: name, value: value).count > 0
  end

  def add_feature_value(name, value)
    if !has_feature_value?(name, value)
      dress_type_features << DressTypeFeature.new({name: name, value: value})
    end
  end

  def is_valid_combination?(dress)
    dress_type_bad_combos.reduce(true) { |is_bad, bad_combo| is_bad || bad_combo.dress_is_bad?(dress) }
  end
end
