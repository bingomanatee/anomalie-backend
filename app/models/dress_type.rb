class DressType < ApplicationRecord
  has_many :dress_type_features
  has_many :dress_type_bad_combos

  attr_accessor :features, :blockers

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
          if DressTypeFeature.valid_option?(option["name"])
            add_feature_value(feature["name"], option["name"])
          end
        end
      end
    end
  end

  def features=(features)
    add_features(features)
  end

  def features()
    feature_list
  end

  def blockers=(blockers)
    update_blockers(blockers)
  end

  def blockers
    dress_type_bad_combos
  end

  # this is a destructive method; it deletes any previous options and replaces it with the argument.
  def update_features(features)
    DressTypeFeature.where(:dress_type_id => id).delete_all
    add_features(features)
  end

  def update_blockers(blockers)
    p '-------- update blockers ', blockers
    DressTypeBadCombo.where(:dress_type_id => id).delete_all
    if blockers.is_a? Array
      blockers.each do |blocker|
        p '--- blocker:', blocker
        combination = blocker[:combination]
        if combination.is_a?(String)
          begin
            combination = JSON.parse(combination)
          rescue
            combination = {}
          end
        end
        p '--- combo', combination
        if !(combination.nil?)
          dress_type_bad_combos << DressTypeBadCombo.new({:dress_type => self, :combination => combination})
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
