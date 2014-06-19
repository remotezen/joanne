Blog::App.helpers do
  def is_pjax?
      env['HTTP_X_PJAX']
   end
end
