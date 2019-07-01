class ArticlesController < ApplicationController
	before_action :set_article, only: [:edit,:update,:show,:destroy]
	before_action :validate_user, except: [:index, :show]
	before_action :require_same_user, only: [:edit, :update, :destroy]
	def index
		@articles = Article.paginate(page:params[:page],per_page: 5)
	end
	
	def new
		@article = Article.new
	end
	def create 
		@article = Article.new(article_params)
		@article.user = current_user
		if @article.save
			redirect_to article_path(@article), flash: {success: "Article was created" }
		else 
			render 'new'
		end
	end
	def show

	end
	def edit
		
	end
	def update
		
		if @article.update(article_params)
			redirect_to article_path(@article), flash: {success: "Article was updated" }
		else 
			render 'edit'
		end
	end
	def destroy
		@article.destroy
		redirect_to articles_path, flash: {success: "Article was deleted"}
	end

	private 
	def set_article
		@article = Article.find(params[:id])
	end

	def article_params
		params.require(:article).permit(:title, :description)
	end
	def require_same_user
			redirect_to root_path, flash: {danger: "You can only edit or delete your own articles"} if current_user != @article.user
	end
end