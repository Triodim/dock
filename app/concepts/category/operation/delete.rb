class Category::Delete < Trailblazer::Operation

  step Model(Category, :find_by)
  step :delete


  def delete(options, model:, **)
    options["name"] = model.name
    model.destroy
  end


end