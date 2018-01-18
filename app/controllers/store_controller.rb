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
    @store = Store.create(name: params[:store_name], user_id: current_user)
    redirect "/stores/#{@store.id}"
  end

  get "/stores/:id/edit" do
    redirect_if_not_logged_in
    @store = Store.find(params[:id])
    erb :'stores/edit'
  end

  post "/stores/:id" do
    redirect_if_not_logged_in
    @store = Store.find(params[:id])
    @store.update(params[:name])
    redirect "/stores/#{@store.id}"
  end

  get "/stores/:id" do
    redirect_if_not_logged_in
    @store = Store.find(params[:id])
    erb :'stores/show'
  end

  get "/stores/:id/delete" do
    redirect_if_not_logged_in
    @store = Store.find(params[:id])
    @store.destroy
    redirect "/stores"
  end
end
