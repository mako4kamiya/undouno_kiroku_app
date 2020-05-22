require 'bundler' #bundlerだけrequireして、
Bundler.require   #bundlerの中のgemを一括でrequire

# ホーム、サインアップ画面
get '/' do
    return erb :signup_signin
end

post '/' do
end

post '/signout' do
end

post '/signin' do
end

get '/user/:id' do
    params[:id] = 1
    params[:name] = "サンプルユーザー"
    return erb :user
end

post 'follow/:id' do
end

post 'unfollow/:id' do
end

post 'user/:id/post_record' do
end

post 'user/:id/delete_record' do
end