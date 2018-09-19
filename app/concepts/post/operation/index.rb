require "trailblazer/operation"

class Post::Index < Trailblazer::Operation

  step :show_all_posts                                #run post.save (or model.save) instead of step :save_new_post

  step :notify

  def show_all_posts(options, params:, **)

    true
  end

  def notify(options, params:, model:, **)
    options["notify"] = "Success"
    puts "Hallow => #{model.errors.full_messages}"
    puts "Options => #{options["notify"]} saved of post #{model.title}"
    #options["result.notify"] = Rails.logger.info("New blog post #{model.title}.")  ???
    true
  end

end