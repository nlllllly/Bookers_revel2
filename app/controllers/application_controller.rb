class ApplicationController < ActionController::Base
    # 全てのページへのログイン前アクセスを禁止する。（実際には、home_controllerだけindexを開けてるからhomeには行ける！）
    before_action :authenticate_user!
    # ユーザ登録・ログイン認証が行われる前に、「configure_permitted_parameters」を実行する！
    before_action :configure_permitted_parameters, if: :devise_controller?

    #アカウント作成後のリダイレクト先
    def after_sign_up_path_for(resource)
      user_path(resource.id)
    end
    
    #ログイン後のリダイレクト先
    def after_sign_in_path_for(resource)
      user_path(resource.id)
    end 

    # ログアウト後のリダイレクト先
    def after_sign_out_path_for(resource)
      root_path
    end 

    protected
    # サインアップをする際に、独自に追加した「name」カラムと、「email」カラムを許可する。
    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email])
        devise_parameter_sanitizer.permit(:sign_in, keys: [:name, :email])
    end


end
