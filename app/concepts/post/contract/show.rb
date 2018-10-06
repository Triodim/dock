module Post::Contract
  class Show < Reform::Form

    property :id

    validates :id, presence: true, numericality: { only_integer: true, message: 'Posts ID is not integer!' }

  end
end
