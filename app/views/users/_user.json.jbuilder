json.extract! user, :id, :firstname, :lastname, :email, :phone, :mobilephone, :mailingcity, :mailingcountry, :mailingpostalcode, :mailingstate, :mailingstreet, :created_at, :updated_at
json.url user_url(user, format: :json)
