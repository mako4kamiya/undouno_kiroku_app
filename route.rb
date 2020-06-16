require 'bundler'
Bundler.require

# class User < ActiveRecord::Base
# end
require_relative 'models' #相対パスで指定でファイルを読み込みできる。

# ホーム、サインアップ画面
get '/' do
    return erb :signup_signin
end

post '/signup' do
    User.create(name: params[:name], password: params[:password]) #バリデーションを行う際にnewメソッドの変えよう。
    redirect '/user/index'
end

get '/user/index' do
    @users = User.all
    erb :user
end

post '/signout' do
end

post '/signin' do
end

get '/user/:id' do
end

post 'follow/:id' do
end

post 'unfollow/:id' do
end

post 'user/:id/post_record' do
end

post 'user/:id/delete_record' do
end