class User::Create < Trailblazer::Operation

  class Present < Trailblazer::Operation
    step Model(User, :new)
    step Contract::Build( constant: User::Contract::Create )
  end

  step Nested(Present)
  step Contract::Validate(key: :user)                      #run validation of input - problem here with messages!
  step Contract::Persist()                                 #run user.save (or model.save) instead of step :save_new_user

end
