
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

#kele_client.create_submission("2547", "10_collab", "https://github.com/courtneym19/blocipedia/commits/10-collab", "test submission")
  def create_submission(checkpoint_id, assignment_branch, assignment_commit_link, comment, enrollment_id=get_me['current_enrollment']['id'])
    response = self.class.post("/checkpoint_submissions", headers: { "authorization": @auth_token },
    body: {"checkpoint_id": checkpoint_id, "assignment_branch": assignment_branch, "assignment_commit_link": assignment_commit_link, "comment": comment, "enrollment_id": enrollment_id})
    if response.code == 200
      puts "YEAAAAAASSSSSasflkjfs!!!"
    else
      puts "Oopsies, try again"
    end
  end

end
