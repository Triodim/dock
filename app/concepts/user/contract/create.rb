require "reform/form/validation/unique_validator"

module User::Contract
  class Create < Reform::Form

    property :nickname
    property :email

    property :password
    property :password_confirmation, virtual: true

    property :active


    validates :nickname, length: { minimum: 2, message: "%{count} characters is the minimum for the name field!" }
    validates :nickname, length: { maximum: 15, message: "%{count} characters is the maximum for the name field!" }
    validates :nickname, unique: true

    validates :password, presence: true
    validate :password_ok

    def password_ok
      if password != password_confirmation
        errors.add(:password, "Password mismatch")
        #binding.pry
      end
    end


    validates :email, unique: true,
                      format: {with: /\w+\@\w+\.\w+/}


  end
end