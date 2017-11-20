class User < ApplicationRecord
  has_many :events, dependent: :nullify
  has_many :tasks, dependent: :destroy
  has_many :event_tasks, through: :tasks, source: :event

  has_many :memberships
  has_many :teams, through: :memberships

  before_save { self.email = email.downcase }
  validates :first_name, presence: true
  validates :last_name, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true,
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }

  def full_name
    "#{first_name} #{last_name}"
  end
end
