module Category::Contract
  class Create < Reform::Form

    property :name
    property :user_id

    validates :name, length: { minimum: 2, message: "%{count} characters is the minimum for the name field!" }
    validates :name, length: { maximum: 15, message: "%{count} characters is the maximum for the name field!" }


  end
end
