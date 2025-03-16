# Projeto: Sistema de Login com Cookies no Rails

Este projeto implementa um sistema de autenticação no Ruby on Rails utilizando cookies para armazenar o estado de login do administrador, com o intuito de entender e manusear a autenticação pelo application.

## Tecnologias Utilizadas

- Ruby on Rails
- Cookies para autenticação
- ActiveRecord para manipulação de dados
- HTML, CSS e ERB basicos.

## Funcionalidades

- Login e logout de administradores
- Autenticação baseada em cookies, não seguro
- Redirecionamento automático para login caso o usuário não esteja autenticado

## Instalação

1. Clone este repositório:

   ```bash
   git clone https://github.com/Luiz-Fernando-Policarpo-Leandro/login_admim_exemplo.git
   cd login_admim_exemplo
   ```

2. Instale as dependências:

   ```bash
   bundle install
   ```

3. Configure o banco de dados:

   ```bash
   rails db:create
   rails db:migrate
   ```

4. Inicie o servidor:

   ```bash
   rails server
   ```

5. Acesse `http://localhost:3000/login` para realizar o login.

## Como Funciona

0. caso seja a primeira vez, o usuario `admin@` será cirado com a senha `1234`
1. O usuário acessa a página de login e insere seu e-mail e senha.
2. O sistema verifica as credenciais no banco de dados.
3. Se forem válidas, um cookie seguro é criado para manter o login ativo.
4. Caso o usuário tente acessar uma página sem estar logado, ele é redirecionado automaticamente para a tela de login.
5. O logout apaga o cookie e redireciona o usuário para a tela inicial.

## Estrutura do Código

### Controlador de Login (`LoginController`)

```ruby
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
```

### Controlador Principal (`ApplicationController`)

```ruby
class ApplicationController < ActionController::Base
  before_action :verificar_login   
  
  def verificar_login
    unless cookies[:producao_admin].present?
      redirect_to '/login'
    end
  end
end
```

## Rotas (`config/routes.rb`)

```ruby
Rails.application.routes.draw do
  resources :administradors
  root to: 'administradors#index'
  get '/login', to: 'login#index'
  post '/login/on', to: 'login#login'
  get '/logout', to: 'login#logout'

end
```

## Contribuição

estou sempre a disposição para ouvir opniões e novas maneiras de melhorar os meus projetos.

1. Fork o repositório
2. Crie um branch com sua alteração (`git checkout -b minha-mudanca`)
3. Commit suas alterações (`git commit -m 'Minha mudança'`)
4. Push para o branch (`git push origin minha-mudanca`)
5. Abra um Pull Request


