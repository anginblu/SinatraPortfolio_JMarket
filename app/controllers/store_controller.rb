class StoreController < ApplicationController

  get "/stores" do
    redirect_if_not_logged_in
    @stores = Store.all
    erb :'stores/index'
  end

  get "/stores/new" do
    redirect_if_not_logged_in
    erb :'stores/new'
  end

  post "/stores" do
    @store = Store.create(name: params[:store_name], user_id: current_user.id)
    if @store.save
      redirect "/stores/#{@store.id}"
    else
      flash[:message] = "Creation failure: please retry!"
      redirect "/stores/new"
    end
  end

  get "/stores/:id/edit" do
    redirect_if_not_logged_in
    redirect_if_not_current_user_store
    @store = Store.find(params[:id])
    erb :'stores/edit'
  end

  # post "/stores/:id" do
  #   @store = Store.find(params[:id])
  #   @store.update(name: params[:name])
  #   if @store.save
  #     redirect "/stores/#{@store.id}"
  #   else
  #     flash[:message] = "Update failure: please retry!"
  #     redirect "/stores/#{@store.id}"
  #   end
  # end

  patch "/stores/:id" do
    redirect_if_not_logged_in
    redirect_if_not_current_user_store
    @store = Store.find(params[:id])
    @store.update(name: params[:name])
    if @store.save
      redirect "/stores/#{@store.id}"
    else
      flash[:message] = "Update failure: please retry!"
      redirect "/stores/#{@store.id}"
    end
  end

  get "/stores/:id" do
    @store = Store.find(params[:id])
    erb :'stores/show'
  end

  get "/stores/:id/delete" do
    redirect_if_not_logged_in
    redirect_if_not_current_user_store
    @store = Store.find(params[:id])
    @store.destroy
    redirect "/stores"
  end
end
