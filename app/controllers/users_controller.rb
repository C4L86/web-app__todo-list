MyApp.get "/new_user" do

  erb :"users/new_user"
end

MyApp.post "/new_user_form" do
  @users = User.all
  @user  = User.new

  @user.name     = params["name"]
  @user.email    = params["email"]
  @user.password = params["password"]

  @user.save

  erb :"todos/welcome"
end

MyApp.get "/update_user/:user_id" do
  @users = User.all
  @user  = User.find_by_id(params[:user_id])

  if @user == nil
    erb :"users/user_update_error"
  elsif @user.id == session["user_id"]

    erb :"users/update_user"
  else
    erb :"users/user_update_error"
  end 
end

MyApp.post "/process_update_user_form/:user_id" do
  @user = User.find_by_id(params[:user_id])

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

MyApp.get "/delete_user/:user_id" do
  @user = User.find_by_id(params[:user_id])

  if @user == nil
     erb :"users/user_delete_error"
  elsif @user.id == session["user_id"]
    @user.delete

    erb :"users/user_delete_success"
  else
    erb :"users/user_delete_error"
  end
end