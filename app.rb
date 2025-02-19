require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require "sinatra/activerecord"

set :database, {adapter:"sqlite3",
                database:"leprosorium.db"}

class Post < ActiveRecord::Base
  validates :author, presence: true
  validates :content, presence: true
end
class Comment < ActiveRecord::Base
end

# def init_db
#   @db = SQLite3::Database.new 'leprosorium.db'
#   @db.results_as_hash = true 
# end

# before do
#   init_db
# end

# configure do
#   init_db
#     @db.execute 'CREATE TABLE IF NOT EXISTS Posts 
#     (
#     id           INTEGER PRIMARY KEY AUTOINCREMENT,
#     created_date DATE,
#     author       TEXT,
#     content      TEXT
#     )'

#     @db.execute 'CREATE TABLE IF NOT EXISTS Comments 
#     (
#     id           INTEGER PRIMARY KEY AUTOINCREMENT,
#     created_date DATE,
#     content      TEXT,
#     post_id      INTEGER
#     )'
# end

before do
  @posts = Post.all
end
get "/" do

          erb :index
end


get '/new' do
  @p = Post.new
            erb :new
end

post '/new' do

  @p = Post.new   params[:post]
 
        if @p.save 
          erb "<h2>Спасибо.Пост опубликован.</h2>"
        else
        @error = @p.errors.full_messages.first
       erb :new
    end
  end   

# get '/details/:id' do
#     post_id = params[:post_id]

#     results = @db.execute 'select * from Posts where id = ?',[post_id]
#     @row = results[0]

#     @comments = @db.execute 'select * from Comments where post_id = ? order by id',[post_id]

#     erb :details  
# end

# post '/details/:post_id' do

#     post_id = params[:post_id]

#     content = params[:content]

#     if content.length <= 0
#         @error = 'Type your comment, please'
#         return erb :details
#       end

#     @db.execute 'insert into Comments 
#     (
#     content,
#     created_date,
#     post_id
#     ) 
#     values 
#     (
#     ?,
#     datetime(),
#     ?
#     )',[content,post_id]

#     redirect to ('/details/' + post_id)
    
# end