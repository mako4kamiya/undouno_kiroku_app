def logged_in? #ログインしてたらtrue,ログインしてなかったらfaulsを返す
    !session[:current_user_id].nil?
end

def login_check #ログインしてない時だけルートにリダイレクトする
    unless logged_in?
        flash[:danger] = "ログインしてください"
        redirect '/'
    end
end