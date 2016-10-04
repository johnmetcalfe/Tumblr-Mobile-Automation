class PasswordFieldFound < StandardError
  def initialize(message="Oops! Password found even though it's not meant to be.")
    super(message)
  end
end

class InvalidTextNotFound < StandardError
  def initialize(message="Invalid Email or Password text not found!")
    super(message)
  end
end
