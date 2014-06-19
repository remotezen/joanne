Blog::App.controllers :accounts, :conditions =>{:protect => true, :user_only => true} do

  def self.protect(protected)
    condition do
      halt 403 unless is_admin?
    end if protected
 end
  def self.user_only(protected)
    condition do
      halt 403 unless is_user?
    end if protected
  end
  get :reindex do
    @title = "All Accounts"
    @accounts = Account.order('created_at').page(params[:page]).per_page(10)
    render 'accounts/index', :layout => :admin
  end
  get :index do
    @title = "All Accounts"
    @accounts = Account.order('created_at DESC').page(params[:page]).per_page(10)
    render 'accounts/index', :layout => :admin
  end
  
  get :new, :protect => false, :user_only => false do
    @title = "new account" 
    @account = Account.new
    render 'accounts/new'
  end



  post :create, :protect => false, :user_only => false do
    params[:account][:role] = :user
    @account = Account.new(params[:account])
    if @account.save
      @title = "account #{@account.id}"
      flash[:success] = "accounted has been created"
       redirect(url(:sessions, :login))
    else             
      @title = "Account created" 
      flash.now[:error] = "unable to create your account right now" 
      render 'accounts/new'
    end
  end

  get :edit, :with => :id, :protect => false, :user_only => true do
    @title = " edit  account #{params[:id]}"
    @account = Account.find(params[:id])
    if @account
      render 'accounts/edit' 
    
    else
      flash[:warning] =:" unable to edit account #{params[:id]}"
      render 'account/edit'
    end
  end

  put :update, :with => :id, :protect => false, :user_only => true do
    @title = "account #{params[:id]}"
    @account = Account.find(params[:id])
    if @account
      if @account.update_attributes(params[:account])
        flash[:info] = "successfully updated account  #{params[:id] }"
        params[:save_and_continue] ? redirect(url(:accounts, :index)) :redirect(url(:accounts, :edit, :id => @account.id))
      else
        flash.now[:error] = "account update error account #{params[:id] }"
        render 'accounts/edit'
      end
    else
      flash[:warning] = " no such account #{params[:id]}"
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Accounts"
    account = Account.find(params[:id])
    if account
      if account != current_user && account.destroy
        flash[:success] = "Account #{params[:id]}  deleted"
         redirect(url(:accounts, :index)) 

      else
        flash[:error] =  "delete error on Account #{params[:id]} "
         redirect(url(:accounts, :index)) 
      end
      redirect url(:accounts, :index)
    else
        flash[:warning] = "Account #{params[:id]}  delete warning"
      halt 404
    end
  end
  get :show do
    @account = Account.find(params[:id])
      render '/accounts/show'
  end

  delete :destroy_many do
    @title = "Accounts"
    unless params[:account_ids]
      flash[:error] = "deleted many accounts  error"
      redirect(url(:accounts, :index))
    end
    ids = params[:account_ids].split(',').map(&:strip)
    accounts = Account.find(ids)
    
    if accounts.include? current_user
      flash[:error] =  "delete error on Accounts #{ids.to_sentence} "
    elsif Account.destroy accounts
    
      flash[:success] = " successfully destroyed #{ids.to_sentence} accounts"
    end
    redirect url(:accounts, :index)
  end
end
