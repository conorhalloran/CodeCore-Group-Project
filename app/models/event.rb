class Event < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: [:slugged, :history, :finders]

  belongs_to :user

<<<<<<< HEAD


  # def to_param
  #   "#{id}-#{title}".parameterize
  # end
=======
  def self.search(search)
    where("location ILIKE ?", "%#{search}%") 
  end

>>>>>>> added search engine to search events by location
end
