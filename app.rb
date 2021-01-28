require 'sinatra/base'
require './lib/bookmark'

class BookmarkManager < Sinatra::Base

	get '/' do
		erb(:index)
		redirect '/bookmarks'
	end

	get '/bookmarks' do
		@bookmarks = Bookmark.all
		erb :"bookmarks/index"
	end

	get '/bookmarks/new' do
		erb :"bookmarks/new"
	end

	post '/bookmarks' do
		Bookmark.create(url: params[:url], title: params[:title])
		redirect '/bookmarks'
	end

	post '/delete' do
		Bookmark.delete(title: params[:title])
		redirect '/bookmarks'
	end

	get '/bookmarks/delete' do
		erb :"bookmarks/delete"
	end



	run! if app_file == $0
end
