class ApplicationController < ActionController::Base

    before_action :configure_permitted_parameters, if: :devise_controller?


    protected
    # サインアップをする際に、独自に追加した「name」カラムと、「email」カラムを許可する。
    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email])
        devise_parameter_sanitizer.permit(:sign_in, keys: [:name, :email])
    end


end
