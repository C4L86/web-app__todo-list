class Todo < ActiveRecord::Base
  def user_todos
    x = User.where({"user_id" => self.id})
    return x
  end
end