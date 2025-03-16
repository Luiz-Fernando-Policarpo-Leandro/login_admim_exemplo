class LoginController < ApplicationController
  skip_before_action :verificar_login
  
  def index
    if !Administrador.exists?
      Administrador.create(Nome:"adm",Email:"adm@",Senha:"1234")
    end
  end

  def login
    if params[:email].present? && params[:password].present?
      adms = Administrador.where(email: params[:email], senha: params[:password])
        if adms.count > 0
          cookies.signed[:producao_admin] = {value: adms.first.id, expires: 1.year.from_now, httponly: true}
          puts "\n",'criado', "\n"
          redirect_to '/'
        else
          puts "\n",'errado', "\n"
        end
    end
  end
  
  def logout
    if cookies[:producao_admin].present?
      cookies.delete :producao_admin
      puts "\n", ' O cookie existe, e foi deletado', "\n"      
    else
      puts "\n", 'O cookie não existe mas foi deletado', "\n"
    end
    redirect_to '/'
  end
end
