class User
  AVAILABLE_ROLES = ["super", "regular", "read_only"]
  attr_reader :username, :password, :role
  
  def initialize(username, password, role)
    @username = username
    @password = password
    @role = role if can_add_role?(role)
  end

  def update_password(new_password)
    @password = new_password

    self
  end

  def can_add_role?(role)
    AVAILABLE_ROLES.include?(role)
  end
end

class Users
  attr_reader :users
  def initialize
    @users = []
  end

  def create_user(username, password, role)
    users.push(User.new(username, password, role))
  end

  def all
    users
  end
end

args = ARGV

users = Users.new

def process_argv(args, users)
  case args[0]
  when "create_user"
    users.send(args[0], args[1], args[2], args[3].split("=")[1])
  when "update_password"
    user = users.create_user("user", "123", "read_only")
    user.send(args[0], args[1])
    users.all
  end
end

puts process_argv(args, users)
