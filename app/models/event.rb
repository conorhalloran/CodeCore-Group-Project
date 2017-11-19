class Event < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: [:slugged, :history, :finders]

  belongs_to :user



  # def to_param
  #   "#{id}-#{title}".parameterize
  # end
end
