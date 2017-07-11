
require 'httparty'
require 'json'
require './lib/roadmap'
require './lib/message'

class Kele
  include HTTParty
  include JSON
  include Roadmap
  include Message
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
  end

  def get_mentor_availability(mentor_id)
    response = self.class.get("/mentors/#{mentor_id}/student_availability", headers: { "authorization": @auth_token } )
    @mentor_schedule = JSON.parse(response.body)
  end

end
