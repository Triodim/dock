module Session::Contract
  class Show < Reform::Form

    property :nickname

    validates :nickname, presence: true
  end
end
