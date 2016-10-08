class PostController < ApplicationController
  def new
    @post = Post.new
    render :new
  end

  def edit
  end

  def show
  end
end
