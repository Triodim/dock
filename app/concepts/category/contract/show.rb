module Category::Contract
  class Show < Reform::Form

    property :id

    validates :id, presence: true, numericality: true
  end
end
