desc 'add space between Latin and CJK characters in topic title and post content'
task 'cjk:reformat' => :environment do
  Parallel.each(Post.all, progress: "Posts") do |post|
    unless post.raw.blank? or post.raw.frozen?
      post.update_column(:raw, AutoCorrect.format(post.raw.dup))
      if post.topic
        post.topic.update_column(:title, AutoCorrect.format(post.topic.title.dup))
        post.topic.update_column(:excerpt, AutoCorrect.format(post.topic.excerpt.dup))
        post.topic.update_column(:fancy_title, AutoCorrect.format(post.topic.fancy_title.dup))
      end
    end
  end

end

