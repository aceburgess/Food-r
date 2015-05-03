def gravitar(email)
  hash = Digest::MD5.hexdigest(email.strip.downcase)
  "<img id='profile-photo' src='http://www.gravatar.com/avatar/#{hash}'>"
end

def gravitar_small(email)
  hash = Digest::MD5.hexdigest(email.strip.downcase)
  "<img src='http://www.gravatar.com/avatar/#{hash}?s=45'>"
end

def gravitar_plain_url(email)
  hash = Digest::MD5.hexdigest(email.strip.downcase)
  "http://www.gravatar.com/avatar/#{hash}?s=20'"
end