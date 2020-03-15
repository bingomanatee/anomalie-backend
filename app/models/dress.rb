class Dress < ApplicationRecord
  has_many :dress_features
  belongs_to :dress_type
  belongs_to :user

  def name
    if !dress_type
      return ''
    end
    dress_type.name
  end

  def matches?(name_or_id)
    if !dress_type
      return false
    end

    dress_type.matches? name_or_id
  end

  def feature_list
    out = {}
    dress_features.each do |feature|
      if out.has_key? feature.name
        out[feature.name] << feature.value
      else
        out[feature.name] = Set.new([feature.value])
      end
    end

    return out
  end

  def has_feature_value?(name, value)
    DressFeature.where(dress_id: id, name: name, value: value).count > 0
  end

  def add_feature_value(name, value)
    if (!has_feature_value?(name, value))
      dress_features << DressFeature.new({name: name, value: value})
    end
  end

  def has_features?(features)
    found = true
    features.each_pair do |key, value|
      if value.is_a? String
        if !has_feature_value?(key, value)
          found = false
        end
      else
        value.each do |item|
          if !has_feature_value?(key, item)
            found = false
          end
        end
      end
    end
    found
  end

  def is_valid_combination?
    if !dress_type
      return false
    end
    dress_type.is_valid_combination?(self)
  end
end
