module Post::Contract
  class Create < Reform::Form

      property :id
      property :title
      property :body
      property :category_id
      property :user_id

      validates :title, length: { minimum: 2, message: "%{count} characters is the minimum for the title field!" }
      validates :body, length: { minimum: 2, too_short: "%{count} characters is the minimum for the body field!" }
      validates :category_id, presence: true, numericality: { only_integer: true, message: 'Categories ID is not integer!' }
      validates :user_id, presence: true
  end
end
