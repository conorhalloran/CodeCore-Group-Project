class Event < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: [:slugged, :history, :finders]
  has_many :tasks, dependent: :destroy
  belongs_to :user
  has_many :teams, class_name: "Team"
  accepts_nested_attributes_for :teams

  validates :event_type, presence: true
  validates :name, presence: true
  validates :location, presence: true
  validates :description, presence: true

  def should_generate_new_friendly_id?
    slug.blank?
  end

  def self.search(search)
    where("location ILIKE ?", "%#{search}%")
  end

end
