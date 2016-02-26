require_relative "./_configure"

DB.define_table("users")
DB.define_column("users", "name", "string")
DB.define_column("users", "email", "string")
DB.define_column("users", "password", "string")

DB.define_table("todos")
DB.define_column("todos", "title", "string")
DB.define_column("todos", "description", "text")
DB.define_column("todos", "completed", "boolean")
DB.define_column("todos", "user_id", "integer")
DB.define_column("todos", "station", "integer")
DB.define_column("todos", "todo_user", "integer")