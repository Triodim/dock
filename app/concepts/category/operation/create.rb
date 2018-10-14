class Category::Create < Trailblazer::Operation
  class Present < Trailblazer::Operation
    step Model(Category, :new)
    step Policy::Pundit( CategoryPolicy, :create? )
    pass :prepare_params
    step Contract::Build( constant: Category::Contract::Create )

    def prepare_params(options, current_user:, **)
      options[:params][:category].merge!(user_id: current_user.id) if options[:params][:category].present?
    end

  end

  step Nested(Present)
  step Contract::Validate(key: :category)
  step Contract::Persist()
end
