require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "my_application_secret"
    use Rack::Flash
  end


  get '/' do
    # session[:user_id]=nil
    erb :index
  end

  helpers do
    def redirect_if_not_logged_in
      if !logged_in?
        flash[:message] = "Please login & retry!"
        redirect "/login"
      end
    end

    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end

    def redirect_if_not_current_user_store
      if !current_user.stores.include?(Store.find(params[:id]))
        flash[:warning] = "No authorized access! Please re-login as the right user with access."
        redirect "/logout"
      end
    end

    def redirect_if_not_current_user_product
      if !current_user.stores.include?(Product.find(params[:id]).store)
        flash[:warning] = "No authorized access! Please re-login as the right user with access."
        redirect "/logout"
      end
    end

  end

end
