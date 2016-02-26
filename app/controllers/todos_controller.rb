MyApp.get "/todo_personal" do
  @todos      = Todo.where({"user_id" => session["user_id"]}).where({"station" => 1})
  @user_todos = Todo.where({"todo_user" => session["user_id"]})
  @todo       = Todo.new
  @user       = User.find_by_id(session["user_id"])

  if session["user_id"] != @user.id
    session["user_id"] = nil
    erb :"todos/invalid_user"

  else
    erb :"todos/todo_personal"
  end
end

MyApp.get "/todo_group" do
  @todos = Todo.where({"station" => 2})
  @todo  = Todo.new
  @users = User.all
  @user  = User.find_by_id(session["user_id"])
  
  erb :"todos/todo_group"
end

MyApp.post "/add_todos" do
  @todos = Todo.all
  @todo  = Todo.new
  # @user  = User.find_by_id(session["user_id"])

  @todo.title       = params["title"]
  @todo.description = params["description"]
  @todo.completed   = false
  @todo.user_id     = session["user_id"]
  @todo.station     = params["station"].to_i
  @todo.todo_user   = params["todo_user"].to_i

  @todo.save

  if @todo.station == 1
    redirect "/todo_personal"
  else
    redirect "/todo_group"
  end
end

MyApp.get "/todo_update/:todo_id" do
  @user  = User.find_by_id(session["user_id"])
  @todo  = Todo.find_by_id(params[:todo_id])

  erb :"todos/todo_update"
end

MyApp.get "/todo_delete/:todo_id" do
  @todos = Todo.where({"user_id" => session["user_id"]})
  @todo  = Todo.find_by_id(params[:todo_id])
  @user  = User.find_by_id(session["user_id"])
  
  @todo.delete
# Create conditional for whether it's a personal or group todo
  if @todo.station == 1
    redirect "/todo_personal"
  else
    redirect "/todo_group"
  end
end

MyApp.post "/process_todo_update_form/:todo_id" do
  @todos = Todo.where({"user_id" => session["user_id"]})
  @todo  = Todo.find_by_id(params[:todo_id])
  @user  = User.find_by_id(session["user_id"])

  # @todo.station     = params["station"]
  @todo.title       = params["title"]
  @todo.description = params["description"]
  @todo.todo_user   = params["todo_user"].to_i

  @todo.save

  if @todo.station == 1
    redirect "/todo_personal"
  else
    redirect "/todo_group"
  end
end
# 
# I believe this is set to allow user to only check their own todos
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

  if @todo.station == 1
    redirect "/todo_personal"
  else
    redirect "/todo_group"
  end
end