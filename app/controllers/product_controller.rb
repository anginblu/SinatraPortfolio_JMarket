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
    @product = Product.create(name: params[:product_name], price: params[:price], store_id: params[:store])
    if @product.save
      redirect "/products/#{@product.id}"
    else
      flash[:message] = "Creation failure: please retry!"
      redirect "/products"
    end
  end

  get "/products/:id/edit" do
    redirect_if_not_logged_in
    redirect_if_not_current_user_product
    @product = Product.find(params[:id])
    erb :'products/edit'
  end

  post "/products/:id" do
    redirect_if_not_logged_in
    @product = Product.find(params[:id])
    @product.update(name: params[:name], price: params[:price], store_id: params[:store])
    if @product.save
      redirect "/products/#{@product.id}"
    else
      flash[:message] = "Update failure: please retry!"
      redirect "/products#{@product.id}"
    end
  end

  get "/products/:id" do
    @product = Product.find(params[:id])
    erb :'products/show'
  end

  get "/products/:id/delete" do
    redirect_if_not_logged_in
    redirect_if_not_current_user_product
    @product = Product.find(params[:id])
    @product.destroy
    redirect "/products"
  end
end
