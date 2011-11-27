class Rating < ActiveRecord::Base
  belongs_to :user
  belongs_to :movie
  
  validates :user, presence: true
  validates :movie, presence: true
  
  scope :good, where("ratings.like IS true")
  scope :bad, where("ratings.like IS false")
  
  scope :latest, where("ratings.like IS NOT ?", nil).order("created_at DESC").limit(10).includes(:user, :movie)
end
