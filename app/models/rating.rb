class Rating < ActiveRecord::Base
  belongs_to :user
  belongs_to :movie
  
  validates :user, presence: true
  validates :movie, presence: true
  
  scope :good, where("like = ?", true)
  scope :bad, where("like = ?", false)
  
  scope :latest, where("like IS NOT '?'", nil).order("created_at DESC").limit(10).includes(:user, :movie)
end
