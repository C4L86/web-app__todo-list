# This controller is for all the CRUD operations related to a Login.

# Note that "logins" are not stored in the database. But there is still
# a reasonable way to think about a "login" as a resource which is created
# and deleted (i.e. 'logging out').
# 
# Reading and Updating a login, however, make a little less sense.
MyApp.get "/" do

  erb :"logins/login"
end

MyApp.post "/user_login_form" do
  @users = User.all
  @user  = User.find_by_email(params["email"])

  if @user == nil
    erb :"logins/login_error"    
  elsif @user.password == params["password"]
    session["user_id"] = @user.id
    erb :"todos/welcome"
  else
    erb :"logins/login_error"
  end
end