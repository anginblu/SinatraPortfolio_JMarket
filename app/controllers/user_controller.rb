class UsersController < ApplicationController

  get '/users/:id' do
    if !logged_in?
      redirect '/stores'
    end

    @user = User.find(params[:id])
    if !@user.nil? && @user == current_user
      erb :'users/show'
    else
      redirect '/stores'
    end
  end

  get '/signup' do
    if session[:user_id].nil?
      erb :'users/new'
    else
      flash[:message] = "You are already logged in.  Please logout first."
      redirect to '/stores'
    end
  end

  post '/signup' do
    if User.find_by(username: params[:username])
      flash[:message] = "That username is already taken!"
      redirect "/signup"
    else
      user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
    end
    if user.save
      session[:user_id] = user.id
      redirect "/stores"
    else
      flash[:message] = "Signup failure: please retry!"
      redirect "/signup"
    end
  end

  get '/login' do
    if session[:user_id].nil?
      erb :'users/login'
    else
      flash[:message] = "You are already logged in.  Please log-out first."
      redirect '/stores'
    end
  end

  post '/login' do
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/stores"
    else
      flash[:message] = "Login failure. Please login again."
      redirect '/users'
    end
  end

  get '/users' do
    erb :'users/index'
  end

  get '/logout' do
    if session[:user_id].nil?
      redirect '/'
    else
      session[:user_id] = nil
      redirect "/login"
    end
  end

end
