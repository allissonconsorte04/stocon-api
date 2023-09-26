require 'jwt'

class V1::AuthController < ApplicationController
    def login
        user = User.find_by(email: params[:email])

        if user&.authenticate(params[:password])
            payload = { user_id: user.id }
            secret_key = 'seu_segredo_secreto'

            token = JWT.encode(payload, secret_key, 'HS256')
            render json: { auth_token: token }, status: :ok
        else
            render json: { error: 'Credenciais inválidas' }, status: :unauthorized
        end
    end
end
