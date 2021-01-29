require 'sinatra/base'
require './lib/bookmark'

class BookmarkManager < Sinatra::Base

	set :method_override, true

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

	get '/bookmarks/:id/edit' do
		@bookmark_id = params[:id]
		erb :"bookmarks/edit"
	end

	patch '/bookmarks/:id' do
	  connection = PG.connect(dbname: 'bookmark_manager_test')
	  connection.exec("UPDATE bookmarks SET url = '#{params[:url]}', title = '#{params[:title]}' WHERE id = '#{params[:id]}';")

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
