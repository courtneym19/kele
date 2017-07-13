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
  def create_message(email, recipient_id, subject, message)

      response = self.class.post("/messages",
      headers: { :authorization => @auth_token, :content_type => 'application/json' },
      body: {"sender": @email, "recipient_id": recipient_id, "subject": subject, "stripped-text": message } )


    raise "Error. Try again?" if response.code != 200
    JSON.parse(response.body)
  end

end
