module PagesHelper
  def feed_item_class(like)
    like ? "feed-pro" : "feed-con"
  end
end
