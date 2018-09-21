module Category::Contract
  class Create < Reform::Form

    property :name

    validates :name, length: { minimum: 2, message: "%{count} characters is the minimum for the name field!" }


  end
end
