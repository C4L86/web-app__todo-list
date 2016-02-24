# This controller is for all the CRUD operations related to a Todo.
MyApp.get "/welcome" do
  @users = User.all
  @user  = User.find_by_id(session["user_id"])
  
  erb :"todos/welcome"
end

MyApp.get "/todo_list" do
  @todos = Todo.all
  @todo  = Todo.new
  @user  = User.find_by_id(session["user_id"])

  if session["user_id"] != @user.id
    session["user_id"] = nil
    erb :"todos/invalid_user"

  else
    erb :"todos/todo_list"
  end
end

MyApp.post "/add_todos" do
  @todos = Todo.all
  @todo  = Todo.new
  @user  = User.find_by_id(session["user_id"])

  @todo.title       = params["title"]
  @todo.description = params["description"]
  @todo.completed   = false
  @todo.user_id     = session["user_id"]

  @todo.save

  erb :"todos/todo_list"
end

MyApp.post "/todo_check[]" do
  @todos = Todo.all
  @todo  = Todo.new
  @user  = User.find_by_id(session["user_id"])

end