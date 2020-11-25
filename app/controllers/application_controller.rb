require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/articles' do
    @articles = Article.all
    erb :index
  end

  get '/articles/new' do
    erb :new 
  end 

  post '/articles' do 
    attrs = params 
    @article = Article.create(attrs)

    redirect to "/articles/#{@article.id}"
  end 

  get '/articles/:id' do 
    id = params[:id] 
    @article = Article.find_by(id: id)

    erb :show
  end 

  get '/articles/:id/edit' do 
    id = params[:id]
    @article = Article.find_by(id: id)

    erb :edit
  end 

  patch '/articles/:id' do 
    # raise params.inspect
    id = params[:id]
    @article = Article.find(id)
    @article.update(title: params[:title])
    @article.update(content: params[:content])
    redirect to "/articles/#{@article.id}"
    erb :show
  end 

  delete '/articles/:id' do
    id = params[:id]
    article = Article.find_by(id: id)
    article.destroy
    redirect to '/articles'

    erb :index
  end 

end
