Blog::App.controllers :toppings do
  get :new, :with=> :id do
    @recipe = Recipe.find(params[:id])
    @title = "create a new topping"
    @top = Topping.new
    render 'toppings/new'
  end

  post :create  do
    @top  = Topping.new(params[:step])
    if @top.save!
      @title = pat(:create_title, :model =>"Top #{@top.id}")
      flash[:success] = pat(:create_success, :model=> 'Topping')
      params[:save_and_continue] ? redirect(url(:recipes, :new)) : redirect(url(:toppings, :edit, :id => @top.id))
    else
      @title = pat(:create_title, :model=>'Topping')
      flash.now[:error] = pat(:create_error, :model =>'Topping')
      redirect  
    end

  end
end
