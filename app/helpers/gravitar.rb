def gravitar(email)
  hash = Digest::MD5.hexdigest(email.strip.downcase)
  "<img src='http://www.gravatar.com/avatar/#{hash}'>"
end