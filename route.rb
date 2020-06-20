require 'bundler'
Bundler.require
enable :sessions

# class User < ActiveRecord::Base
# end
require_relative 'models' #相対パスで指定でファイルを読み込みできる。
require_relative 'helpers' #相対パスで指定でファイルを読み込みできる。

# ホーム、サインアップ画面
get '/' do
    if logged_in? 
        redirect "/user/#{session[:current_user_id]}"
    else
        return erb :login_form
    end
end

post '/user_create' do
    # User.create(name: params[:name], password: params[:password]) #バリデーションを行う際にnewメソッドの変えよう。
    user = User.new(name: params[:name], password: params[:password])
    if  user.save
        session[:current_user_id] = user.id
        flash[:success] = "こんにちは#{user.name}さん！"
        redirect "/user/#{user.id}"
    else
        flash[:danger] = "すでに使われている名前です。"
        redirect '/'
    end
end

get '/user_delete/:id' do
    login_check
    User.find_by(id: params[:id]).destroy
    session[:current_user_id] = nil
    flash[:success] = "ユーザー情報を消去しました。"
    redirect '/'
end

post '/login' do
    user = User.find_by(name: params[:name])
    if !user
        flash[:danger] = "登録されていません。"
        redirect '/'
    elsif user.password != params[:password]
        flash[:danger] = "パスワードが間違っています。"
        redirect '/'
    else
        session[:current_user_id] = user.id
        flash[:success] = "こんにちは#{user.name}さん！"
        redirect "/user/#{user.id}"
    end
end

get '/logout' do
    login_check
    session[:current_user_id] = nil
    flash[:success] = "ログアウトしました。"
    redirect '/'
end

get '/users' do
    login_check
    @users = User.all
    erb :users
end

get '/user/:id' do
    login_check
    @current_user = User.find_by(id: session[:current_user_id])
    erb :user
end

post 'follow/:id' do
end

post 'unfollow/:id' do
end

post 'user/:id/post_record' do
end

post 'user/:id/delete_record' do
end