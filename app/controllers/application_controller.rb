require 'jwt'

class ApplicationController < ActionController::API

  def bearer_token

    bearer = request.headers["Bearer"]

    if !bearer.is_a? String
      puts '--- bad format'
      return nil
    end

    puts '--- processing bearer token', bearer

    begin
      decoded = JWT.decode bearer, nil, false
      puts '---- decoded token: ', decoded

      decoded[0]
    rescue
      puts '---- cannot decode ', bearer
    end
  end

  def user_for_token
    token = bearer_token

    if token.nil?
      return nil
    end
    puts
    sub = token["sub"]
    name = token["name"]

    if !(sub && name)
      return nil
    end
    puts '---- getting user like ', sub, 'name', name
    User.find_or_create_by :user_name => name, :path => sub
  end
end
