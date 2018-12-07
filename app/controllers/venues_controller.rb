class VenuesController < ApplicationController
  def index
    @q = Venue.ransack(params.fetch("q", nil))
    @venues = @q.result(:distinct => true).includes(:bookmarks, :neighborhood, :fans, :specialties).page(params.fetch("page", nil)).per(10)
    @neighborhoods = Neighborhood.all

    # @location_hash = Gmaps4rails.build_markers(@venues.where.not(:address_latitude => nil)) do |venue, marker|
    #   marker.lat venue.address_latitude
    #   marker.lng venue.address_longitude
    #   marker.infowindow "<h5><a href='/venues/#{venue.id}'>#{venue.name}</a></h5><small>#{venue.address_formatted_address}</small>"
    # end
  
    @location_data = []

    @venues.where.not(:address_latitude => nil).each do |venue|
    url_safe_street_address = URI.encode(venue.address)
    url = "https://maps.googleapis.com/maps/api/geocode/json?address="+url_safe_street_address+"&key=AIzaSyA5qwIlcKjijP_Ptmv46mk4cCjuWhSzS78"
    raw_data = open(url).read
    parsed_data = JSON.parse(raw_data)
    f = parsed_data.fetch("results").at(0)
    lat = f.fetch("geometry").fetch("location").fetch("lat").to_s
    lng = f.fetch("geometry").fetch("location").fetch("lng").to_s
    venue = venue
    @location_data.push([lat,lng,venue])
    end

    render("venues_templates/index.html.erb")
  end

  def show
    @bookmark = Bookmark.new
    @venue = Venue.find(params.fetch("id"))
    @neighborhoods = Neighborhood.all
    @dishes = Dish.all
    @bookmarks = Bookmark.all
    @bookmarked_dishes = Bookmark.where("venue_id = "+params.fetch("id")).pluck("dish_id").uniq

    url_safe_street_address = URI.encode(@venue.address)

    # ==========================================================================
    # Your code goes below.
    # The street address the user input is in the string @street_address.
    # A URL-safe version of the street address, with spaces and other illegal
    #   characters removed, is in the string url_safe_street_address.
    # ==========================================================================

    url = "https://maps.googleapis.com/maps/api/geocode/json?address="+url_safe_street_address+"&key=AIzaSyA5qwIlcKjijP_Ptmv46mk4cCjuWhSzS78"

    raw_data = open(url).read

    parsed_data = JSON.parse(raw_data)
    
    f = parsed_data.fetch("results").at(0)

    @latitude = f.fetch("geometry").fetch("location").fetch("lat").to_s
    @longitude = f.fetch("geometry").fetch("location").fetch("lng").to_s

    render("venues_templates/show.html.erb")
  end

  def new
    @venue = Venue.new

    render("venues_templates/new.html.erb")
  end

  def create
    
    url_safe_street_address = URI.encode(params.fetch("address"))
    url = "https://maps.googleapis.com/maps/api/geocode/json?address="+url_safe_street_address+"&key=AIzaSyA5qwIlcKjijP_Ptmv46mk4cCjuWhSzS78"
    raw_data = open(url).read
    parsed_data = JSON.parse(raw_data)
    f = parsed_data.fetch("results").at(0)

    @venue = Venue.new

    @latitude = f.fetch("geometry").fetch("location").fetch("lat").to_s
    @longitude = f.fetch("geometry").fetch("location").fetch("lng").to_s
    @venue.name = params.fetch("name")
    @venue.address = params.fetch("address")
    @venue.neighborhood_id = params.fetch("neighborhood_id")
    @venue.address_formatted_address = url_safe_street_address
    @venue.address_latitude = f.fetch("geometry").fetch("location").fetch("lat").to_s
    @venue.address_longitude = f.fetch("geometry").fetch("location").fetch("lng").to_s

    save_status = @venue.save

    if save_status == true
      referer = URI(request.referer).path

      case referer
      when "/venues/new", "/create_venue"
        redirect_to("/venues")
      else
        redirect_back(:fallback_location => "/", :notice => "Venue created successfully.")
      end
    else
      render("venues_templates/new.html.erb")
    end
  end

  def edit
    @venue = Venue.find(params.fetch("id"))

    render("venues_templates/edit.html.erb")
  end

  def update
    @venue = Venue.find(params.fetch("id"))

    @venue.name = params.fetch("name")
    @venue.address = params.fetch("address")
    @venue.neighborhood_id = params.fetch("neighborhood_id")

    save_status = @venue.save

    if save_status == true
      referer = URI(request.referer).path

      case referer
      when "/venues/#{@venue.id}/edit", "/update_venue"
        redirect_to("/venues/#{@venue.id}", :notice => "Venue updated successfully.")
      else
        redirect_back(:fallback_location => "/", :notice => "Venue updated successfully.")
      end
    else
      render("venues_templates/edit.html.erb")
    end
  end

  def destroy
    @venue = Venue.find(params.fetch("id"))

    @venue.destroy

    if URI(request.referer).path == "/venues/#{@venue.id}"
      redirect_to("/", :notice => "Venue deleted.")
    else
      redirect_back(:fallback_location => "/", :notice => "Venue deleted.")
    end
  end
end
