# This controller is for all the CRUD operations related to a Todo.
MyApp.get "/todos/welcome" do
  @user = session["user_id"]
  
  erb :"todos/welcome"
end