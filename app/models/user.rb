class User < ActiveRecord::Base
  has_secure_password
  
  has_many :ratings, dependent: :destroy
  attr_accessible :username, :password
  
  validates :username, presence: true,
                       format: {with: /^\w+$/},
                       uniqueness: {case_sensitive: false}
                       
  validates :password, presence: {on: :create}
  
  validates :password_confirmation, presence: {on: :create}
  
  scope :with_username, lambda { |username| where("UPPER(username) = ?", username.upcase) }
  
  def hide_movie(movie, like = nil)
    ratings.create(movie: movie, like: like) unless ratings.find_by_movie_id(movie.id)
  end
  
  def self.username_taken?(username)
    with_username(username).count > 0
  end
  
  def self.authenticate(username, password)
    User.where("UPPER(username) = ?", username.upcase).try(:first).try(:authenticate, password)
  end
end
