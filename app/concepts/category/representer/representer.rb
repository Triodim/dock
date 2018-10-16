require 'roar/json'

class Category::Representer < Roar::Decorator
  include Roar::JSON

  property :name
  property :created_at, as: :created_time, exec_context: :decorator

  def created_at
    represented.created_at.strftime('%l:%M%P')
  end
end
