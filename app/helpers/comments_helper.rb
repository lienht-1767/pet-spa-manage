module CommentsHelper
  def count_comments(id)
    Comment.count_cmt(id)
  end
end
