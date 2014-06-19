Blog::App.controllers :steps do
  
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
  
  get :new, :with=> :id do
    @recipe = Recipe.find(params[:id])
    @title = "create a new recipe"
    @step = Step.new
    render 'steps/new'

  end
  get :index do
    @title = "All steps"
    @step = Step.all

  end

  post :create  do
    @step = Step.new(params[:step])
    image = params[:step][:image]
    upload = Upload.new
    upload = image
    upload = File.open('public/images')
    if @step.save!
      @title = pat(:create_title, :model =>"step #{@step.id}")
      flash[:success] = pat(:create_success, :model=> 'step')
      params[:save_and_continue] ? redirect(url(:steps, :new, :id =>params[:step][:recipe_id])) : redirect(url(:steps, :edit, :id => @step.id))
    else
      @title = pat(:create_title, :model=>'recipe')
      flash.now[:error] = "unable to create step"
      redirect 'recipes/new'
    end

  end
  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "step #{ params[:id]}")
    @step = Step.find(params[:id])
    if @step
      render 'steps/edit'
    else
      flash[:warning] ="could not save edit for #{params[:id]}"
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "step #{params[:id]}")
    @step = Recipe.find(params[:id])
    if @step
      if @step.update_attributes(params[:step])
       flash[:success] =  " updated step #{params[:id]}"
        params[:save_and_continue] ?
          redirect(url(:steps, :index)) :
          redirect(url(:steps, :edit, :id => @step.id))
      else
        flash.now[:error] = "there was an error updating step #{params[:id] }" 
        render 'steps/edit'
      end
    else
      flash[:warning] =  " could not update step #{params[:id]}"
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Steps"
    step  = Step.find(params[:id])
    if step
      if step.destroy
        flash[:success] = " deleted step #{params[:id]}"
      else
        flash[:error] = "unable to delete step #{ params[:id]}" 
      end
      redirect url(:steps, :index)
    else
      flash[:warning] = "could find step #{params[:id]}"
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Step"
    unless params[:steps_ids]
      flash[:error] = "destroyed many steps #{ids.to_sentence}" 
      redirect(url(:recipes, :index))
    end
    ids = params[:recipe_ids].split(',').map(&:strip)
    recipes  = Step.find(ids)
    
    if Recipe.destroy recipes
    
      flash[:success] = " destroyed steps #{ids.to_sentence}"
    end
    redirect url(:steps, :index)
  end

end
