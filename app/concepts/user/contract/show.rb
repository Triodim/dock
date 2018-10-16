module User::Contract
  class Show < Reform::Form
    property :id

    validates :id, presence: true, numericality: { only_integer: true, message: 'User`s ID is not integer!' }
  end
end
