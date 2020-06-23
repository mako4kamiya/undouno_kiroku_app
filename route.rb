require 'bundler'
Bundler.require
enable :sessions
require_relative 'models' #相対パスで指定でファイルを読み込みできる。
require_relative 'helpers' #相対パスで指定でファイルを読み込みできる。

########################
# ホーム、サインアップ画面 #
########################
get '/' do
    if logged_in? 
        redirect "/user/#{session[:current_user_id]}"
    else
        return erb :login_form
    end
end

##############
# ユーザー登録 #
##############
post '/user_create' do
    password = BCrypt::Password.create(params[:password])
    user = User.new(name: params[:name], password: password)
    if  user.save
        session[:current_user_id] = user.id
        flash[:success] = "こんにちは#{user.name}さん！"
        redirect "/user/#{user.id}"
    else
        flash[:danger] = "すでに使われている名前です。"
        redirect '/'
    end
end

##############
# ユーザー消去 #
##############
delete '/user_delete/:id' do
    login_check
    @user = User.find_by(id: params[:id])
    @user.destroy
    session[:current_user_id] = nil
    flash[:success] = "ユーザー情報を消去しました。"
    redirect '/'
end

###########
# ログイン #
###########
post '/login' do
    user = User.find_by(name: params[:name])
    if !user
        flash[:danger] = "登録されていません。"
        redirect '/'
    elsif  BCrypt::Password.new(user.password) != params[:password]
        flash[:danger] = "パスワードが間違っています。"
        redirect '/'
    else
        session[:current_user_id] = user.id
        flash[:success] = "こんにちは#{user.name}さん！"
        redirect "/user/#{user.id}"
    end
end

############
# ログアウト #
############
get '/logout' do
    login_check
    session[:current_user_id] = nil
    flash[:success] = "ログアウトしました。"
    redirect '/'
end

######################
# ユーザー一覧画面（仮） #
#####################
get '/users' do
    login_check
    @current_user = User.find_by(id: session[:current_user_id])
    @users = User.all
    erb :users
end

##################
# ユーザー1詳細画面 #
##################
get '/user/:id' do
    login_check
    @user = User.find_by(id: params[:id])
    @current_user = User.find_by(id: session[:current_user_id])
    muscles = Muscle.where(user_id: @user.id, date: Date.today)
    abs_min = muscles.where(part: "abs").all.sum(:min)
    back_min = muscles.where(part: "back").all.sum(:min)
    arm_min = muscles.where(part: "arm").all.sum(:min)
    lower_body_min = muscles.where(part: "lower_body").all.sum(:min)
    jog_min = muscles.where(part: "jog").all.sum(:min)
    # @chart1 = ChartJS.bar do
    #     data do
    #         labels ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat","Sun"]
    #         dataset "Cats" do
    #             color :random
    #             data [12, 19, 3, 5, 2, 3, 10]
    #         end 
    #         dataset "Dogs" do
    #             color :random
    #             data [10, 12, 3, 4, 5, 3,10]
    #         end
    #     end
    # end
    @chart2 = ChartJS.radar do
        data do
            labels ["腹筋系", "背筋系", "上腕系", "下半身系", "ジョギング"]
            dataset "きょうのきろく" do
                color "rgba(254,99,132,0.1)"
                borderColor "rgb(254,99,132)"
                # data [12, 19, 13, 15, 12]
                data [abs_min, back_min, arm_min, lower_body_min, jog_min]
            end 
        end
    end
    erb :user
end

###########
# 運動記録 #
###########
post '/add_record_muscles' do
    date = Date.today
    muscle = Muscle.new(part: params[:part], min: params[:min], user_id: session[:current_user_id], date: date)
    if muscle.save
        flash[:success] = "記録しました"
        redirect "/"
    else
        flash[:danger] = "部位と時間を選択してください"
        redirect "/"
    end
end

post 'user/:id/delete_record' do
end

post 'follow/:id' do
end

post 'unfollow/:id' do
end

get '/help' do
    erb :index
end