module Post::Contract
  class Create < Reform::Form

      property :title
      property :body

      validates :title, length: { minimum: 2, message: "%{count} characters is the minimum" }
      validates :body, length: { minimum: 2, too_short: "%{count} characters is the minimum" }

  end
end
