class SearchsController < ApplicationController
  
  
  def search
    @range = params[:range]
    search = params[:search]
    word = params[:word]
    
    if @range == '1'
      @user = User.search(search,word)
    else
      @post_image = PostImage.search(search,word)
    end
  end
end
