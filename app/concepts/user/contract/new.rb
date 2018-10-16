module User::Contract
  class New < Reform::Form
    property :nickname
    property :password

    validates :nickname, presence: true
    validates :password, presence: true
  end
end
