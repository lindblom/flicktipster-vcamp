class PagesController < ApplicationController
  before_filter :check_login, only: [:rate]
  before_filter :check_admin, only: [:destroy, :add_movie]
  
  def index
    if logged_in?
      if Movie.without_user(current_user).count == 0
        @movie = nil
      else
        @movie = Movie.without_user(current_user).offset(rand(Movie.without_user(current_user).count)).limit(1).first
      end
    else
      @movie = Movie.offset(rand(Movie.count)).limit(1).first
    end
    @feed = Rating.latest
    render "no_movies" unless @movie
  end
  
  def destroy
    Movie.find(params[:id]).destroy
    redirect_to root_path, notice: "Movie deleted."
  end
  
  def login
    user = User.authenticate(params[:login][:username], params[:login][:password])
    if user
      session[:login] = nil
      cookies.permanent.signed[:user_id] = user.id
      redirect_to root_path, notice: "Welcome back."
    elsif User.username_taken?(params[:login][:username])
      session[:login] = nil
      redirect_to root_path, alert: "Wrong password."
    else
      user = User.new(params[:login])
      user.password_confirmation = session[:login][:password] if session[:login] && params[:login][:username] == session[:login][:username]
      if user.save
        session[:login] = nil
        cookies.permanent.signed[:user_id] = user.id
        redirect_to root_path, notice: "Registered and logged in."
      elsif user.errors.messages[:username]
        session[:login] = nil
        redirect_to root_path, alert: "Bogus username! Only use letters, numbers and underscore."
      else
        session[:login] = params[:login]
        redirect_to root_path, notice: "Type in the password again to register."
      end
    end
  end
  
  def rate
    if movie = Movie.find_by_id(params[:id])
      current_user.hide_movie(movie, check_rating(params[:like]))
      redirect_to root_path
    else
      redirect_to root_path, alert: "Could not find the movie."
    end
  end
  
  def logout
    cookies.permanent.signed[:user_id] = nil
    redirect_to root_path, notice: "You have logged out."
  end
  
  def add_movie
    redirect_to(root_path, alert: "The was already in the database.") and return unless Movie.scrape_imdb(params[:imdb_id])
    @movie = Movie.find_by_imdb(params[:imdb_id])
    @feed = Rating.latest
    render "index"
  end
  
  private
  
    def check_login
      redirect_to root_path, alert: "You need to login to rate." unless logged_in?
    end
    
    def check_admin
      redirect_to root_path, alert: "You have to be admin to do that." unless admin?
    end
    
    def check_rating(rating)
      if rating == "yes"
        true
      elsif rating == "no"
        false
      else
        nil
      end
    end
end
