namespace :dev do
  desc "Hydrate the database with some dummy data to make it easier to develop"
  task prime: :environment do
    Cuisine.destroy_all
    Dish.destroy_all
    Neighborhood.destroy_all
    Venue.destroy_all
    User.destroy_all
    Bookmark.destroy_all

    cuisine_hashes = [
      { :name => "Breakfast" },
      { :name => "American" },
      { :name => "Drink" },
      { :name => "Italian" },
      { :name => "Salad" },
      { :name => "French" },
      { :name => "Dessert" },
      { :name => "Classic" },
      { :name => "Japanese" },
      { :name => "Seafood" },
      { :name => "Indian" }
    ]

    cuisine_hashes.each do |cuisine_hash|
      cuisine = Cuisine.new
      cuisine.name = cuisine_hash[:name]
      cuisine.save
    end

    puts "There are now #{Cuisine.count} cuisines in the database."

    dish_hashes = [
      { :name => "Bagel", :cuisine => "Breakfast" },
      { :name => "Chili", :cuisine => "American" },
      { :name => "Burger", :cuisine => "American" },
      { :name => "Michelada", :cuisine => "Drink" },
      { :name => "Gnocchi", :cuisine => "Italian" },
      { :name => "Fruit Bowl", :cuisine => "Salad" },
      { :name => "Charcuterie", :cuisine => "French" },
      { :name => "Tres Leches", :cuisine => "Dessert" },
      { :name => "Pot Pie", :cuisine => "Classic" },
      { :name => "Grits", :cuisine => "Breakfast" },
      { :name => "Ramen", :cuisine => "Japanese" },
      { :name => "Banana Split", :cuisine => "Dessert" },
      { :name => "Veggie Burger", :cuisine => "American" },
      { :name => "Old Fashioned", :cuisine => "Drink" },
      { :name => "Fried Pickles", :cuisine => "American" },
      { :name => "Bloody Mary", :cuisine => "Drink" },
      { :name => "Spaghetti", :cuisine => "Italian" },
      { :name => "Watermelon Salad", :cuisine => "Salad" },
      { :name => "Negroni", :cuisine => "Drink" },
      { :name => "Lamb Chops", :cuisine => "Classic" },
      { :name => "Creme Brulee", :cuisine => "Dessert" },
      { :name => "Pancakes", :cuisine => "Breakfast" },
      { :name => "Gin and Tonic", :cuisine => "Drink" },
      { :name => "Mussels", :cuisine => "Seafood" },
      { :name => "Chicken Tikka Masala", :cuisine => "Indian" },
      { :name => "Biscuits and Gravy", :cuisine => "Breakfast" }
    ]

    dish_hashes.each do |dish_hash|
      cuisine = Cuisine.find_by({ :name => dish_hash[:cuisine] })
      dish = Dish.new
      dish.name = dish_hash[:name]
      dish.cuisine_id = cuisine.id
      dish.save
    end

    puts "There are now #{Dish.count} dishes in the database."

    neighborhood_hashes = [
      { :name => "Lincoln Park", :city => "Chicago", :state => "IL" },
      { :name => "Humboldt Park", :city => "Chicago", :state => "IL" },
      { :name => "Logan Square", :city => "Chicago", :state => "IL" },
      { :name => "Near North Side", :city => "Chicago", :state => "IL" },
      { :name => "West Loop", :city => "Chicago", :state => "IL" },
      { :name => "Noble Square", :city => "Chicago", :state => "IL" },
      { :name => "Wicker Park", :city => "Chicago", :state => "IL" },
      { :name => "Bucktown", :city => "Chicago", :state => "IL" },
      { :name => "Bridgeport", :city => "Chicago", :state => "IL" },
      { :name => "Hyde Park", :city => "Chicago", :state => "IL" }
    ]

    neighborhood_hashes.each do |neighborhood_hash|
      neighborhood = Neighborhood.new
      neighborhood.name = neighborhood_hash[:name]
      neighborhood.city = neighborhood_hash[:city]
      neighborhood.state = neighborhood_hash[:state]
      neighborhood.save
    end

    puts "There are now #{Neighborhood.count} neighborhoods in the database."

    venue_hashes = [
      {:name => "The Bagelers Coffeehouse", :address => "2461 N Lincoln Ave, Chicago, IL 60614", :neighborhood => "Lincoln Park"},
      {:name => "Rangoli", :address => "2421 W North Ave, Chicago, IL 60647", :neighborhood => "Humboldt Park"},
      {:name => "Lockdown Bar & Grill", :address => "1024 N Western Ave, Chicago, IL 60622", :neighborhood => "Humboldt Park"},
      {:name => "Longman & Eagle", :address => "2657 N Kedzie Ave, Chicago, IL 60647", :neighborhood => "Logan Square"},
      {:name => "Ruth's Chris Steak House", :address => "431 N Dearborn St, Chicago, IL 60654", :neighborhood => "Near North Side"},
      {:name => "Little Goat", :address => "820 W Randolph St, Chicago, IL 60607", :neighborhood => "West Loop"},
      {:name => "Chicago Cut Steakhouse", :address => "300 N Lasalle, Chicago, IL 60654", :neighborhood => "Near North Side"},
      {:name => "Billy Sunday", :address => "3143 W Logan Blvd, Chicago, IL 60647", :neighborhood => "Logan Square"},
      {:name => "Unite Urban Grill", :address => "1450 W Chicago Ave, Chicago, IL 60642", :neighborhood => "Noble Square"},
      {:name => "Balena", :address => "1633 N Halsted St, Chicago, IL 60614", :neighborhood => "Lincoln Park"},
      {:name => "Umami Burger", :address => "1480 N Milwaukee Ave, Chicago, IL 60622", :neighborhood => "Wicker Park"},
      {:name => "Handlebar", :address => "2311 W North Ave, Chicago, IL 60647", :neighborhood => "Wicker Park"},
      {:name => "The Whistler", :address => "2421 N Milwaukee Ave, Chicago, IL 60647", :neighborhood => "Logan Square"},
      {:name => "Skylark", :address => "2149 S Halsted St, Chicago, IL 60608", :neighborhood => "West Loop"},
      {:name => "Shake Shack", :address => "66 E Ohio Street, Chicago, IL 60611", :neighborhood => "Near North Side"},
      {:name => "Margie's Candies", :address => "1960 N Western Ave, Chicago, IL 60647", :neighborhood => "Bucktown"},
      {:name => "MAX's Wine Dive", :address => "1482 N. Milwaukee Ave, Chicago, IL 60622", :neighborhood => "Wicker Park"},
      {:name => "Kanela Breakfast Club", :address => "1408 N Milwaukee Ave, Chicago, IL 60622", :neighborhood => "Wicker Park"},
      {:name => "The Publican", :address => "837 W Fulton Market, Chicago, IL 60607", :neighborhood => "West Loop"},
      {:name => "Mott St", :address => "1401 N Ashland Ave, Chicago, IL 60622", :neighborhood => "Wicker Park"},
      {:name => "Pleasant House Bakery", :address => "964 W 31st St, Chicago, IL 60608", :neighborhood => "Bridgeport"},
      {:name => "The Southern", :address => "1840 W North Ave, Chicago, IL 60622", :neighborhood => "Wicker Park"},
      {:name => "Slurping Turtle", :address => "116 W Hubbard St, Chicago, IL 60654", :neighborhood => "Near North Side"},
      {:name => "Big Star", :address => "1531 N Damen, Chicago, IL 60622", :neighborhood => "Wicker Park"},
      {:name => "Plein Air Cafe & Eatery", :address => "5751 S Woodlawn Ave, Chicago, IL 60637", :neighborhood => "Hyde Park"},
      {:name => "Bavette's Bar & Boeuf", :address => "218 W Kinzie St, Chicago, IL 60654", :neighborhood => "Near North Side"},
      {:name => "Au Cheval", :address => "800 W Randolph St, Chicago, IL 60607", :neighborhood => "West Loop"}
    ]

    venue_hashes.each do |venue_hash|
      neighborhood = Neighborhood.find_by({ :name => venue_hash[:neighborhood] })
      venue = Venue.new
      venue.name = venue_hash[:name]
      venue.address = venue_hash[:address]
      venue.neighborhood_id = neighborhood.try(:id)
      url_safe_street_address = URI.encode(venue.address)
      url = "https://maps.googleapis.com/maps/api/geocode/json?address="+url_safe_street_address+"&key=AIzaSyA5qwIlcKjijP_Ptmv46mk4cCjuWhSzS78"
      raw_data = open(url).read
      parsed_data = JSON.parse(raw_data)
      f = parsed_data.fetch("results").at(0)
      venue.address_latitude = f.fetch("geometry").fetch("location").fetch("lat")
      venue.address_longitude = f.fetch("geometry").fetch("location").fetch("lng")
      venue.save
    end

    puts "There are now #{Venue.count} venues in the database."

    usernames = ["alice", "bob", "carol", "eve"]

    usernames.each do |username|
      user = User.new
      user.username = username
      user.email = "#{username}@example.com"
      user.password = "password"
      user.save
    end

    puts "There are now #{User.count} users in the database."

    bookmark_hashes = [
      { :user => "bob", :dish => "Michelada", :venue => "Big Star", :notes => "" },
      { :user => "bob", :dish => "Gnocchi", :venue => "MAX's Wine Dive", :notes => "Braised short rib" },
      { :user => "alice", :dish => "Fruit Bowl", :venue => "Kanela Breakfast Club", :notes => "" },
      { :user => "bob", :dish => "Charcuterie", :venue => "The Publican", :notes => "" },
      { :user => "bob", :dish => "Tres Leches", :venue => "Mott St", :notes => "" },
      { :user => "alice", :dish => "Pot Pie", :venue => "Pleasant House Bakery", :notes => "Mushroom, kale" },
      { :user => "alice", :dish => "Grits", :venue => "The Southern", :notes => "" },
      { :user => "bob", :dish => "Ramen", :venue => "Slurping Turtle", :notes => "" },
      { :user => "alice", :dish => "Banana Split", :venue => "Margie's Candies", :notes => "" },
      { :user => "alice", :dish => "Veggie Burger", :venue => "Shake Shack", :notes => "" },
      { :user => "bob", :dish => "Chili", :venue => "Skylark", :notes => "" },
      { :user => "alice", :dish => "Old Fashioned", :venue => "The Whistler", :notes => "" },
      { :user => "alice", :dish => "Fried Pickles", :venue => "Handlebar", :notes => "" },
      { :user => "alice", :dish => "Bloody Mary", :venue => "Handlebar", :notes => "" },
      { :user => "carol", :dish => "Burger", :venue => "Umami Burger", :notes => "" },
      { :user => "bob", :dish => "Spaghetti", :venue => "Balena", :notes => "Sea urchin" },
      { :user => "alice", :dish => "Watermelon Salad", :venue => "Unite Urban Grill", :notes => "" },
      { :user => "bob", :dish => "Negroni", :venue => "Billy Sunday", :notes => "" },
      { :user => "carol", :dish => "Lamb Chops", :venue => "Chicago Cut Steakhouse", :notes => "" },
      { :user => "carol", :dish => "Creme Brulee", :venue => "Ruth's Chris Steak House", :notes => "" },
      { :user => "carol", :dish => "Pancakes", :venue => "Little Goat", :notes => "Sourdough" },
      { :user => "alice", :dish => "Gin and Tonic", :venue => "Longman & Eagle", :notes => "" },
      { :user => "alice", :dish => "Mussels", :venue => "Lockdown Bar & Grill", :notes => "Coconut curry sauce" },
      { :user => "bob", :dish => "Mussels", :venue => "Lockdown Bar & Grill", :notes => "Coconut curry sauce" },
      { :user => "eve", :dish => "Mussels", :venue => "Lockdown Bar & Grill", :notes => "Coconut curry sauce" },
      { :user => "eve", :dish => "Chicken Tikka Masala", :venue => "Rangoli", :notes => "" },
      { :user => "eve", :dish => "Michelada", :venue => "Big Star", :notes => "" },
      { :user => "alice", :dish => "Michelada", :venue => "Big Star", :notes => "" },
      { :user => "eve", :dish => "Pot Pie", :venue => "Plein Air Cafe & Eatery", :notes => "" },
      { :user => "eve", :dish => "Old Fashioned", :venue => "Bavette's Bar & Boeuf", :notes => "" },
      { :user => "eve", :dish => "Burger", :venue => "Au Cheval", :notes => "Bacon, fried egg" },
      { :user => "eve", :dish => "Biscuits and Gravy", :venue => "Little Goat", :notes => "" }
    ]

    bookmark_hashes.each do |bookmark_hash|
      user = User.find_by({ :username => bookmark_hash[:user] })
      dish = Dish.find_by({ :name => bookmark_hash[:dish] })
      venue = Venue.find_by({ :name => bookmark_hash[:venue] })
      bookmark = Bookmark.new
      bookmark.user_id = user.id
      bookmark.dish_id = dish.id
      bookmark.venue_id = venue.id
      bookmark.notes = bookmark_hash[:notes]
      bookmark.save
    end

    puts "There are now #{Bookmark.count} bookmarks in the database."

  end
end
