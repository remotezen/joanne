Blog::App.controllers :recipes, :conditions => {:protect => true }do
  before do
    store_referer
  end

  def self.protect(protected)
    condition do
      halt 403 unless is_admin?
    end if protected
  end
  def self.user_only(protected)
    condition do
      soft_redirect unless is_user?
    end
    end if protected
  get :show, :with => :id,:protect => false, :user_only => true do
    
    @recipe = Recipe.find_by_slug(params[:id])
    viewed = Viewed.new(:user_id => current_user.id, :recipe_id =>@recipe.id) 
    if viewed.save!
      render 'recipes/show'
    else
     flash[:info] = "unable to save preferences"
      render 'recipes/show'
    end
  end

  get :reindex do
    @title = "All your recipes"
    @recipes = Recipe.order('created_at').page(params[:page]).per_page(10)
    render 'recipes/index' , layout: :admin
  end

  get :index, :protect => true  do
    @title = "All your recipes"
    @recipes = Recipe.order('created_at DESC').page(params[:page]).per_page(10)
    render 'recipes/index' , layout: :admin
  end
  get :archive, :with => [:id, :month], :protect => false do
    @id = params[:id]
    @month = params[:month]
    @arr = @id.split('-')
    y = @arr[0]
    m = @arr[1]
    @name = "Recipe"
    @archive = Recipe .where("MONTH(created_at) = ? and YEAR(created_at) = ?", m,y).order('id DESC')
    @count = @archive.count
    render 'shared/archive'
  end
  get :recent, :protect => false, :user_only => true do
   @recipes =  Recipe.order("created_at DESC").page(params[:page]).per_page(10)

    render 'recipes/recent'
  end

  
  # get :index, :map => '/foo/bar' do
  #   session[:foo] = 'bar'
  #   render 'index'
  # end

  # get :sample, :map => '/sample/url', :provides => [:any, :js] do
  #   case content_type
  #     when :js then ...
  #     else ...
  # end

  # get :foo, :with => :id do
  #   'Maps to url '/foo/#{params[:id]}''
  # end

  # get '/example' do
  #   'Hello world!'
  # end
  #
  get :new do
    @title = "create a new recipe"
    @recipe = Recipe.new
    render 'recipes/new'
  end
  
  post :create do
    @recipe = Recipe.new(params[:recipe])
    image = params[:recipe][:image]
    upload = Upload.new
    upload = image
    upload = File.open('public/images')
    if @recipe.save!
      @title = pat(:create_title, :model =>"recipe #{@recipe.id}")
      flash[:success] = "created new recipe" 
      params[:save_and_continue] ? redirect(url(:steps, :new, :id=>@recipe.id)) 
      : redirect(url(:recipes, :edit, :id => @recipe.id)) 
    else
      @title = pat(:create_title, :model=>'recipe')
      flash.now[:error] = "unable to create recipe"
      redirect (url(:recipes,:new))
    end
  end
  
  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "recipe #{params[:id]}")
    @recipe  = Recipe.find(params[:id])
    if @recipe
      render 'recipes/edit'
    else
      flash[:warning] =  " unable to edit recipe #{params[:id]}"
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "recipe #{params[:id]}")
    @recipe = Recipe.find(params[:id])
    if @recipe
      if @recipe.update_attributes(params[:recipe])
        flash[:success] =  " update recipe #{params[:id]}"
        params[:save_and_continue] ?
          redirect(url(:recipes, :index)) :
          redirect(url(:recipes, :edit, :id => @recipe.id))
      else
        flash.now[:error] = "unable to update recipe #{params[:id] }" 
        render 'recipes/edit'
      end
    else
      flash[:warning] = " recipe #{params[:id]} no found"
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Recipes"
    recipe  = Recipe.find(params[:id])
    if recipe 
      if recipe.destroy
        flash[:success] = " deleted  recipe #{params[:id]}"
      else
        flash[:error] =  "unable to delete recipe #{params[:id] }"
      end
      redirect url(:recipes, :index)
    else
      flash[:warning] =  " could not find recipe #{params[:id]}"
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Recipe"
    unless params[:recipes_ids]
      flash[:error] = "could not destroy all those recipes"
      redirect(url(:recipes, :index))
    end
    ids = params[:recipe_ids].split(',').map(&:strip)
    recipes  = Recipe.find(ids)
    
    if Recipe.destroy recipes
    
      flash[:success] = " deleted recipes #{ids.to_sentence}"
    end
    redirect url(:recipes, :index)
  end
end
