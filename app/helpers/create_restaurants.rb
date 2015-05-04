helpers do

  def create_restaurants_and_votes names_and_phones, local_area, event
    names_and_phones.each do |name, phone|
      unless Restaurant.find_by(phone: phone)
        current_restaurant = yelp_search_by_phone phone
        new_restaurant = create_restaurant current_restaurant, local_area
        create_initial_vote new_restaurant, logged_user, event
      end
    end
  end

  def create_restaurant current_restaurant, local_area
    new_restaurant = Restaurant.create(
      name: current_restaurant.name,
      business_id: current_restaurant.id,
      phone: current_restaurant.phone,
      url: current_restaurant.url,
      address: current_restaurant.location.address.first,
      location: convert_to_string(local_area),
      picture_url: current_restaurant.image_url
    )
    new_restaurant
  end

  def create_initial_vote restaurant, organizer, event
    new_vote = Vote.create(
      restaurant_id: restaurant.id,
      user_id: organizer.id,
      event_id: event.id
    )
    new_vote
  end

end