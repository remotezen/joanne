Blog::App.controllers :controllers do
  get :profile do
    content_type :text
    current_user.to_yaml
  end

  get :destroy do
    current_user = nil
    redirect url_for(:blog, :home)
  end
end
