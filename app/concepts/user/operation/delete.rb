class User::Delete < Trailblazer::Operation

  step Model(User, :find_by)
  step :set_active

  def set_active(options, **)
    options[:model][:active] = false
    options[:model].save
  end

end