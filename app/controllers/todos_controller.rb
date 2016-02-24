# This controller is for all the CRUD operations related to a Todo.
MyApp.get "/todos/welcome" do
  @users = User.all
  @user  = User.find_by_id(session["user_id"])
  
  erb :"todos/welcome"
end