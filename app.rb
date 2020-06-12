require 'bundler' #bundlerだけrequireして、
Bundler.require   #bundlerの中のgemを一括でrequire

class User < ActiveRecord::Base
end

# ホーム、サインアップ画面
get '/' do
    return erb :signup_signin
end

post '/signup' do
    # name = params[:name]
    # password = params[:password]
    # db.exec_params("INSERT INTO users (name, password) VALUES ($1, $2)", [name, password])
    User.create(name: params[:name], password: params[:password]) #バリデーションを行う際にnewメソッドの変えよう。
    redirect '/user/index'
end

get '/user/index' do
    # @users = db.exec_params("SELECT * FROM users").to_a
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