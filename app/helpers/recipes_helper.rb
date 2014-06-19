# Helper methods defined here can be accessed in any controller or view in the application
Blog::App.helpers do
 def ingredient(content) 
   arr =content.to_s.split(',').to_a
 end
  
  # def simple_helper_method
  #  ...
  # end
end
