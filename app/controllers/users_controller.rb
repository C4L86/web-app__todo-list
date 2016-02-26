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
  session["user_id"] = @user.id
  redirect "/welcome"
end

MyApp.get "/welcome" do
  @users = User.all
  @user  = User.find_by_id(session["user_id"])
  
  erb :"users/user_welcome"
end

MyApp.get "/user_update/:user_id" do
  @users = User.all
  @user  = User.find_by_id(params[:user_id])

  if @user == nil
    erb :"users/user_update_error"
  
  elsif @user.id == session["user_id"]
    erb :"users/user_update"
  
  else
    erb :"users/user_update_error"
  end 
end

MyApp.post "/process_user_update_form/:user_id" do
  @user = User.find_by_id(params[:user_id])

  @user.name     = params["name"]
  @user.email    = params["email"]
  @user.password = params["password"]

  if @user == nil
     erb :"users/user_update_error"
  
  elsif @user.id == session["user_id"]
    @user.save
    redirect "/user_profile"
  
  else
    erb :"users/user_update_error"
  end
end

MyApp.get "/delete_user/:user_id" do
  @user = User.find_by_id(params[:user_id])

  if @user == nil
     erb :"users/user_delete_error"
  
  elsif @user.id == session["user_id"]
    session["user_id"] = nil
    @user.delete
    erb :"users/user_delete_success"
  
  else
    erb :"users/user_delete_error"
  end
end

MyApp.get "/user_profile" do
  @users = User.all
  @user = User.find_by_id(session["user_id"])

  erb :"users/user_profile"
end