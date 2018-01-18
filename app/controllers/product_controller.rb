class ProductController < ApplicationController

  get "/products" do
    redirect_if_not_logged_in
    @products = Product.all
    erb :'products/index'
  end

  post "/products/new" do
    @store = Store.find_by(name: params[:store])
    erb :'products/new'
  end

  get "/products/new" do
    redirect_if_not_logged_in
    erb :'products/new'
  end

  post "/products" do
    @product = Product.create(name: params[:product_name], price: params[:price], user_id: current_user)
    update_stores_for_product
    redirect "/products/#{@product.id}"
  end

  get "/products/:id/edit" do
    redirect_if_not_logged_in
    @product = Product.find(params[:id])
    erb :'products/edit'
  end

  post "/products/:id" do
    redirect_if_not_logged_in
    @product = Product.find(params[:id])
    @product.update(name: params[:name], price: params[:price])
    update_stores_for_product
    redirect "/products/#{@product.id}"
  end

  get "/products/:id" do
    redirect_if_not_logged_in
    @product = Product.find(params[:id])
    erb :'products/show'
  end

  get "/products/:id/delete" do
    redirect_if_not_logged_in
    @product = Product.find(params[:id])
    @product.destroy
    redirect "/products"
  end
end
