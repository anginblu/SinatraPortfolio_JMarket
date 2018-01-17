# Online Marketplace for selling products

##Objectives

1. 1. Build a full scale Sinatra application that uses:

+ A sqlite database
+ ActiveRecord
+ RESTful routes
+ Sessions
+ Login/Logout

## Overview

The goal of this project is to build an Online Marketplace (aka JMarket).

You'll be implementing JMarket using multiple objects that interact, including separate classes for User, Store, and Product.

Just like with ebay, a user should not be able to take any actions (except sign-up), unless they are logged in. Once a user is logged in, they should be able to create, edit and delete their own stores and products within those stores, as well as view all the stores/products.

##Structure
1. User: requires a username and password for login + email address for communications & has many stores and many products
2. Store: requires a name & has many products and belongs to a user
3. Product: requires a name and price & belongs to one store and one user
