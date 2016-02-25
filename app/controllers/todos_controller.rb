MyApp.get "/welcome" do
  @users = User.all
  @user  = User.find_by_id(session["user_id"])
  
  erb :"todos/welcome"
end

MyApp.get "/todo_personal" do
  @todos = Todo.where({"user_id" => session["user_id"]})
  @todo  = Todo.new
  @user  = User.find_by_id(session["user_id"])

  if session["user_id"] != @user.id
    session["user_id"] = nil
    erb :"todos/invalid_user"

  else
    erb :"todos/todo_personal"
  end
end

MyApp.get "/todo_group" do

  erb :"todos/todo_group"
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

  erb :"todos/todo_personal"
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

  redirect "/todo_personal"
end

MyApp.post "/process_todo_update_form/:todo_id" do
  @todos = Todo.where({"user_id" => session["user_id"]})
  @todo  = Todo.find_by_id(params[:todo_id])
  @user  = User.find_by_id(session["user_id"])

  @todo.title       = params["title"]
  @todo.description = params["description"]

  @todo.save

  redirect "/todo_personal"
end

MyApp.post "/todo_check" do
  @todos = Todo.where({"user_id" => session["user_id"]})
  @user  = User.find_by_id(session["user_id"])
#
# Need to place the following in a Model method
  if params == {}
    @todos.each do |todo|
      todo.completed = false
      todo.save
    end
  else
    params.each do |key, value|
      todo = Todo.find_by_id(key)
      if value == ["on"]
        todo.completed = true
      end
      todo.save
    end
  end
  
  redirect "/todo_personal"
end