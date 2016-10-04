class PasswordFieldFound < StandardError
  def initialize(message="Oops! Password found even though it's not meant to be.")
    super(message)
  end
end
