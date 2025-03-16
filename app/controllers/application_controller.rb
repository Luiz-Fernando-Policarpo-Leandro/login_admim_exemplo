class ApplicationController < ActionController::Base
    before_action :verificar_login   
    def verificar_login
        unless cookies[:producao_admin].present?
            redirect_to '/login'
        end 
    end
end