require 'sinatra/base'
require 'sinatra/flash'
require 'uri'
require './lib/bookmark'
require './database_connection_setup'

class BookmarkManager < Sinatra::Base

	set :method_override, true
	enable :sessions
	register Sinatra::Flash

	get '/' do
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
		flash[:notice] = "You must submit a valid URL." unless Bookmark.create(url: params[:url], title: params[:title])

		redirect '/bookmarks'
	end

	post '/delete' do
		Bookmark.delete(title: params[:title])
		redirect '/bookmarks'
	end

	get '/bookmarks/delete' do
		erb :"bookmarks/delete"
	end

	get '/bookmarks/:id/edit' do
		@bookmark = Bookmark.find(id: params[:id])
		# @bookmark_id = params[:id]
		erb :"bookmarks/edit"
	end

	patch '/bookmarks/:id' do
		Bookmark.update(id: params[:id], title: params[:title], url: params[:url])
	  redirect('/bookmarks')
	end

	# post '/bookmarks/:id' do
	# 	redirect('/bookmarks')
	# end

	# post '/bookmarks/find' do
	# 	Bookmark.find(title: params[:title])
	# 	redirect '/bookmarks/update'
	# end
	#
	# get '/bookmarks/update' do
	# 	erb :"bookmarks/update"
	# end

	run! if app_file == $0
end
