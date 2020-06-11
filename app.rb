require 'bundler' #bundlerだけrequireして、
Bundler.require   #bundlerの中のgemを一括でrequire

# db = PG::connect(
#     :host => 'localhost',
#     :user => ENV.fetch('USER', 'MakoKamiya'),
#     :password => '',
#     :dbname => 'undouno_kiroku_app'
# )

# ホーム、サインアップ画面
get '/' do
    return erb :signup_signin
end

post '/signup' do
    name = params[:name]
    password = params[:password]
    db.exec_params("INSERT INTO users (name, password) VALUES ($1, $2)", [name, password])
    redirect '/user/index'
end

get '/user/index' do
    @users = db.exec_params("SELECT * FROM users").to_a
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