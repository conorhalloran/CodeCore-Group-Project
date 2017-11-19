class Event < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: [:slugged, :history, :finders]

  belongs_to :user

  validates :event_type, {
    presence: true
  }

  validates :name, {
    presence: true
  }

  validates :location, {
    presence: true
  }

  validates :description, {
    presence: true
  }
  

  # def to_param
  #   "#{id}-#{title}".parameterize
  # end
  def self.search(search)
    where("location ILIKE ?", "%#{search}%") 
  end

end
