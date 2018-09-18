require "trailblazer/operation"

class Post::Create < Trailblazer::Operation

  step Model( Post, :new )                                 #create a post by calling Post.new
  step Contract::Build( constant: Post::Contract::Create ) #fillin properties of the post with params
  step Contract::Validate(key: :post)                      #run validation of input - problem here with messages!
  step Contract::Persist()                                 #run post.save (or model.save) instead of step :save_new_post

  step :notify

=begin
  def save_new_post(options, params:, model:, **)
    #model.update_attributes(params[:post])
    model.title = params[:post][:title]
    model.body = params[:post][:body]
    model.save
  end
=end


  def notify(options, params:, model:, **)
    options["notify"] = "Success"
    puts "Hallow => #{model.errors.full_messages}"
    puts "Options => #{options["notify"]} saved of post #{model.title}"
    #options["result.notify"] = Rails.logger.info("New blog post #{model.title}.")  ???
    true
  end

end