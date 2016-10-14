class ArticleLikesController < ApplicationController
  before_action :find_article
  before_action :authenticate_user!  

  def create   
    if (article_likes_params['like_level'] == 'Ruim' or article_likes_params['like_level'] == 'Péssimo') and 
       article_likes_params['comment'] == ''
      msg = "Não gostou do artigo? É importante que nos diga como podemos melhora-lo, pode comentar?"
      redirect_to article_path(@article), notice: msg
    else
      @articlelike = @article.articlelikes.create(article_likes_params)
      @articlelike.user_id = current_user.id
      @articlelike.save
      if @articlelike.save
        msg = "Obrigado pelo sua opnião, os autores agradecem!"
        redirect_to article_path(@article), notice: msg
      else
        render 'new'
      end
    end    
  end

  def destroy
    @article.articlelikes.first.destroy
    redirect_to article_path(@article)    
  end

  private 

  def find_article
    @article = Article.find(params[:article_id])    
  end

  def article_likes_params
    params.require(:article_like).permit(:comment,:like_level)
  end

end
