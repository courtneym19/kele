module Message

  def get_messages(page = nil)
    if page
      response = self.class.get("/message_threads", headers: { "authorization": @auth_token }, body: {"page": page } )
    else
      response = self.class.get("/message_threads", headers: { "authorization": @auth_token } )
    end
    @messages = JSON.parse(response.body)
  end

  def create_message

  end

end
