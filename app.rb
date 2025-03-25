# Load necessary dependencies
require 'sinatra'
require 'sinatra/reloader' if development?
require 'rack-livereload' if development?
require 'sinatra/activerecord'
require 'bcrypt'
require 'dotenv/load'
require_relative 'models/user'
require_relative 'models/mood'
require_relative 'helpers/date_formatter'
helpers DateFormatter

# Set the server port and binding
set :port, ENV.fetch("PORT", 8080)
set :bind, '0.0.0.0'

# Enable session management and set a secure session secret
enable :sessions
set :session_secret, ENV.fetch('SESSION_SECRET') { raise "SESSION_SECRET must be set in production!"}

# Configure SQLite3 for the development environment
set :database, { adapter: "sqlite3", database: "db/development.sqlite3" }

# Helper method to retrieve the currently logged-in user
helpers do
  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end
end

#######################
#        GET ROUTES   #
#######################

# Home route: sets a home-specific body class and loads the latest moods
get '/' do
  @body_class = "home flex flex-col min-h-screen"  # Enable animated background on home
  all_moods = Mood.includes(:user).order(updated_at: :desc)
  # Keep only one mood per user (the most recently updated one)
  @latest_moods = all_moods.uniq { |mood| mood.user_id }
  erb :index
end

# Profile route: displays the profile page if the user is logged in
get '/profile' do
  redirect '/login' unless session[:user_id]
  @user = User.find(session[:user_id])
  erb :profile
end

# Login route: renders the login page
get '/login' do
  erb :login
end

# Signin route: renders the account creation page
get '/signin' do
  erb :signin
end

# Mood route: allows logged-in users to select their mood
get '/mood' do
  redirect '/login' unless session[:user_id]
  @user = User.find(session[:user_id])
  erb :select_mood
end

# Logout route: clears the session and redirects to home
get '/logout' do
  session.clear
  redirect '/'
end

# Debug route: displays the session and cookies as JSON (for debugging purposes)
get '/debug' do
  content_type :json
  { session: session, cookies: request.cookies }.to_json
end

#########################
#       POST ROUTES     #
#########################

# Account creation route: creates a new user account and redirects to login
post '/signin' do
  user = User.new(
    name: params[:name],
    email: params[:email],
    password: params[:password]
  )

  if user.save
    # Redirect to login page upon successful account creation
    redirect '/login'
  else
    # Display only the first error message if saving fails
    @error = user.errors.full_messages.first
    erb :signin
  end
end

# Login route: authenticates the user and redirects to the mood selection page
post '/login' do
  user = User.find_by(email: params[:email])
  if user && user.authenticate(params[:password])
    session[:user_id] = user.id
    redirect '/mood'
  else
    @error = "Invalid email or password"
    erb :login
  end
end

# Profile update route: allows a logged-in user to update their name
post '/profile' do
  redirect '/login' unless session[:user_id]
  @user = User.find(session[:user_id])
  if @user.update(name: params[:name])
    redirect '/'
  else
    @error = "Error updating your profile."
    erb :profile
  end
end

# Mood update route: creates or updates a user's mood based on the emoji selected
post '/mood' do
  redirect '/login' unless session[:user_id]

  existing_mood = Mood.find_by(user_id: session[:user_id])
  if existing_mood
    existing_mood.update(emoji: params[:emoji])
  else
    Mood.create(emoji: params[:emoji], user_id: session[:user_id])
  end

  redirect '/'
end

#########################
#    NOT FOUND ROUTE    #
#########################

# Catch-all route for 404 errors: renders the not_found view
not_found do
  status 404
  erb :not_found  # This renders views/not_found.erb
end
