class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = ["Apples","Carrots"]

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end
    elsif req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)
    else
      resp.write "Path Not Found"
    end

    if @@cart.length < 1
      resp.write "Your cart is empty" 
    elsif req.path.match(/cart/)
      @@cart.each do |item|
      resp.write "#{item}\n"
      end
    end
    
    if req.path.match(/add/)
      add_term = req.params["item"]
      if @@items.include?(add_term)
        @@cart << add_term
        resp.write "added #{add_term}"
      else
        resp.write "We don't have that item"
      end
    end
    resp.finish
  end

  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end
end




# if req.path.match(/items/)
#   @@items.each do |item|
#     resp.write "#{item}\n"
#   end
# elsif req.path.match(/search/)

#   search_term = req.params["q"]

#   if @@items.include?(search_term)
#     resp.write "#{search_term} is one of our items"
#   else
#     resp.write "Couldn't find #{search_term}"
#   end

# else
#   resp.write "Path Not Found"
# end