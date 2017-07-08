
require 'httparty'
require 'json'

class Kele
  include HTTParty
  include JSON
  base_uri "https://www.bloc.io/api/v1/"

  def initialize(email, password)
    @email = email
    @password = password

    response = self.class.post('/sessions', body: { email: @email, password: @password })
    raise "Invalid email or password. Try again?" if response.code == 404
    @auth_token = response["auth_token"]
  end

  def get_me
    response = self.class.get('/users/me', headers: { :authorization => @auth_token })
    @user_info = JSON.parse(response.body)
    p @user_info
  end
end
