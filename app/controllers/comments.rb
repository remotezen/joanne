Blog::App.controllers :comments, 
  :conditions => { :user_only => true} do

  def self.user_only(protected)
    condition do
      soft_redirect unless is_user?
    end if protected
 end
  get :reindex do
    @comments = Comment.order(:id).page(params[:page]).per_page(10)
    render 'comments/index', :layout=> :admin
  end
  get :index, :user_only => true  do
    @comments = Comment.order("created_at DESC").page(params[:page]).per_page(10)
    render 'comments/index', :layout=> :admin
  end
  get :archive, :with => [:id,:month] do
    @id = params[:id]
    @month= params[:month]
    @arr = @id.split('-')
    y = @arr[0]
    m = @arr[1]
    @name = "Comment"
    @archive = Comment.where("MONTH(created_at) = ? and YEAR(created_at) = ?", m,y).order('id DESC')
    @count = @archive.count
    render 'shared/archive'
  end
  
  get  :new, :with=> :id  do
      @comment = Comment.new
      render  'comments/new', :layout => !is_pjax?
  end 
  
  get :show , :with => :id do
    @comment = Comment.find_by_slug(params[:id])
    render 'comments/show'
  end
  
  post :create do
    id = params[:post_id]
    @post = Post.find(id)
    @comment  = @post.comments.build(:comment =>  params[:comment], :account_id => params[:account_id])
    if recaptcha_valid? 
      if @comment.save
       flash[:info] = "comment was recorded"
       redirect_to  url_for(:blog, :show, :id=>@post.slug) 
      else
        flash[:error] = "there was a saving your comment"
       redirect_to  url_for(:blog, :home) 
      end
    else  
      flash[:error] = "invalid captcha"
      redirect url_for(:comments, :new, :id => id)
    end

  end

  get :find_many do
    @account = Account.find(params[:id])
    @title = "Comments by #{@account.user_name}"
    @comments = Comment.where("account_id = ?", params[:id])
    render 'comments/index'
  end

  get :edit, :with => :id do
    @title = " Edit content of Comment #{params[:id]}"
    @comment = Comment.find(params[:id])
    if @comment
      render 'comment/edit'
    else
      flash[:warning] = " create error #{params[:id]}"
      halt 404
    end
  end

  put :update, :with => :id  do
    @title = "Update Comment #{params[:id]}"
    @comment = Comment.find(params[:id])
    if @comment
      if @comment.update_attributes(params[:comment])
        flash[:success] = " update success for blog #{params[:id]}"
        params[:save_and_continue] ?
          redirect(url(:comments, :index)) :
          redirect(url(:comments, :edit, :id => @comment.id))
      else
        flash.now[:error] = "blog update error on blog #{params[:id] }" 
        render 'blog/edit'
      end
    else
      flash[:warning] = "unable to update blog #{params[:id]}" 
      halt 404
    end
  end


  delete :destroy, :with => :id do
    @title = "Comments"
    comment = Comment.find(params[:id])
    if comment 
      if comment.destroy
        flash[:success] = "Comment #{params[:id]}  deleted"
        redirect url(:comments, :index)
     

      else
        flash[:error] =  "delete error on comment #{params[:id]} "
        redirect url(:comments, :index)
      end

    else
      flash[:warning] = "no such comment #{params[:id]}  delete warning"
      halt 404
    end
  end

  delete :destroy_many  do
    @title = "Comments"
    unless params[:comment_ids]
      flash[:error] = "deleted many Comments  error"
      redirect(url(:comments, :index))
    end
    ids = params[:comments_ids].split(',').map(&:strip)
    comments  = Comment.find(ids)
    
    if Comment.destroy comments
      flash[:success] = " successfully destroyed #{ids.to_sentence} Comments"
    end
    redirect url(:comments, :index)
  end
  
  
end
 # escape_javascript(render('users/unfollow')
