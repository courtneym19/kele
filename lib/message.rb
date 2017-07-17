module Message

  def get_messages(page = nil)
    if page
      response = self.class.get("/message_threads", headers: { "authorization": @auth_token }, body: {"page": page } )
    else
      response = self.class.get("/message_threads", headers: { "authorization": @auth_token } )
    end
    @messages = JSON.parse(response.body)
  end
# kele_client.create_message("courtneymiller919@gmail.com", 2299934, "test subject", "test body", nil)
  def create_message(sender, recipient_id, token = nil, subject, message)
      if token
        response = self.class.post("/messages",
        headers: { :authorization => @auth_token },
        body: {"sender": sender, "recipient_id": recipient_id, "token": token, "subject": subject, "stripped-text": message} )
      else
        response = self.class.post("/messages",
        headers: { :authorization => @auth_token },
        body: {"sender": sender, "recipient_id": recipient_id, "subject": subject, "stripped-text": message} )
      end

      if response.code == 200
        p "woohoo"
      end
  end

end
