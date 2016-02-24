# This controller is for all the CRUD operations related to a User.
MyApp.get "/new_user" do

  erb :"users/new_user"
end

MyApp.post "/new_user_form" do
  @user = User.new

  @user.name     = params["name"]
  @user.email    = params["email"]
  @user.password = params["password"]

  @user.save

  erb :"todos/welcome"
end

MyApp.get "/update_user" do

  erb :"users/update_user"
end

MyApp.post "/update_user_form/" do
  @user = User.find_by_id(params["email"])

  @user.name     = params["name"]
  @user.email    = params["email"]
  @user.password = params["password"]

  if @user == nil
     erb :"users/user_update_error"
  elsif @user.id == session["user_id"]
    @user.save

    erb :"users/user_update_success"
  else
    erb :"users/user_update_error"
  end
end