class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @micropost = current_user.microposts.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end

  def help
    # Code In here
  end

  def about
    # Code In here
  end

  def contact
    # Code In here
  end
end
