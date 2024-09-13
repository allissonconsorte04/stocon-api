class JwtAuthMiddleware
    def initialize(app)
        @app = app
    end

    def call(env)
        if requires_authentication?(env)
            authenticate_request(env)
        else
            @app.call(env)
        end
    end

    private

    def requires_authentication?(env)
        return false if env['PATH_INFO'] == '/health'
        return false if env['PATH_INFO'] == '/v1/login'
        return true
    end

    def authenticate_request(env)
        token = extract_token_from_request(env)
        if token
            begin
                secret_key = 'seu_segredo_secreto'
                decoded_token = JWT.decode(token, secret_key, true, algorithm: 'HS256')
                return @app.call(env)
            rescue JWT::DecodedError
                return [401, { 'Content-Type' => 'application/json' }, ['{"error": "Token JWT inválido"}']]
            end
        else
            return [401, { 'Content-Type' => 'application/json' }, ['{"error": "Token JWT ausente"}']]
        end
    end

    def extract_token_from_request(env)
        auth_header = env['HTTP_AUTHORIZATION']
        if auth_header && auth_header.match(/^Bearer/)
            token = auth_header.split(' ').last
            return token
        end
        nil
    end
end