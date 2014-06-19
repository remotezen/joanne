Blog::App.controllers :sessions do
  get :banned do
    halt 403 
  end
end
