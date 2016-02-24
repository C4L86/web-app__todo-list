# This controller is for all the CRUD operations related to a User.
MyApp.get "/new_user" do

  erb :"users/create"
end

MyApp.post "/new_user_form" do
  @user = User.new

  @user.name     = params["user_name"]
  @user.email    = params["user_email"]
  @user.password = params["user_password"]

  @user.save

  erb :""
end