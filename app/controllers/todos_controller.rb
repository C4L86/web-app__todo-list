# This controller is for all the CRUD operations related to a Todo.
MyApp.get "/welcome" do
  @users = User.all
  @user  = User.find_by_id(session["user_id"])
  
  erb :"todos/welcome"
end

MyApp.get "/todo_list" do
  @todos = Todo.where({"user_id" => session["user_id"]})
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
  @todos = Todo.where({"user_id" => session["user_id"]})
  @todo  = Todo.new
  @user  = User.find_by_id(session["user_id"])

  @todo.title       = params["title"]
  @todo.description = params["description"]
  @todo.completed   = false
  @todo.user_id     = session["user_id"]

  @todo.save

  erb :"todos/todo_list"
end

MyApp.get "/todo_update/:todo_id" do
  @todo = Todo.find_by_id(params[:todo_id])

  erb :"todos/todo_update"
end

MyApp.get "/todo_delete/:todo_id" do
  @todos = Todo.where({"user_id" => session["user_id"]})
  @todo  = Todo.find_by_id(params[:todo_id])
  @user  = User.find_by_id(session["user_id"])
  
  @todo.delete

  erb :"todos/todo_delete_success"
end

MyApp.post "/process_todo_update_form/:todo_id" do
  @todos = Todo.where({"user_id" => session["user_id"]})
  @todo  = Todo.find_by_id(params[:todo_id])
  @user  = User.find_by_id(session["user_id"])

  @todo.title       = params["title"]
  @todo.description = params["description"]

  @todo.save

  erb :"todos/todo_update_success"
end

MyApp.post "/todo_check" do
  @todos = Todo.where({"user_id" => session["user_id"]})
  @user  = User.find_by_id(session["user_id"])
  @todo_arr = params.to_a

  @todo_arr.each do |todo|
    x = Todo.find_by_id(todo[0])
    x.completed = true
    x.save
  end
  
  erb :"todos/todo_check_success"
end