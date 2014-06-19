Blog::App.controllers :blog, :conditions => {:protect => true} do

  before do
    store_referer
    set_posts_cache
    #gone
  end

  def self.protect(protected)
    condition do
      halt 403 unless is_admin?
    end if protected
  end
  def self.user_only(protected)
    condition do
      soft_redirect unless is_user?
    end if protected
  end

  def self.banned(protected)
    condition do
      halt 403 if banned?
    end if protected
  end

  get :index  do
    @title = "All Posts Reversed"
    @posts = Post.order('created_at DESC').page(params[:page]).per_page(10)
    render 'blog/index', :layout => :admin
  end
  get :reindex do
    @title = "All Posts Forward"
    @posts = Post.order('created_at').page(params[:page]).per_page(10)
    render 'blog/index', :layout => :admin
  end

  get :new do
    @title = "new post" 
    @post = Post.new
    render 'blog/new'
  end
  

  post :create  do
    image = params[:post][:image]
    
    @post = Post.new(params[:post])
    upload = Upload.new
    upload = image 
    upload = File.open('public/images')
    @post.account = current_user
    if @post.save
     delete_posts_cache
      flash[:info] = "blog created" 
      set_posts_cache
      @title = pat(:create_title, :model => "post #{@post.id}")
      params[:save_and_continue] ? redirect(url(:blog, :index)) : redirect(url(:blog, :edit, :id => @post.id))
    else
      flash.now[:error] = "unable to create blog"
      @title = pat(:create_title, :model => 'post')
      render 'blog/new'
    end
  end
  
  get :rss, :protect => false, :user_only => true  do

    #@posts  = Post.find(:all, :limit=> 20, :order=>'id desc')
    @posts = Padrino.cache.get('posts')
    @title = "Blog"

    builder  :rss 
  end
  
  
  
  get :archive, :with=>[:id,:month] do
    
    @id = params[:id]
    @month =params[:month]
    @name = "Post"
    @arr = @id.split('-')
    y = @arr[0]
    m = @arr[1]
    @archive = Post .where("MONTH(created_at) = ? and YEAR(created_at) = ?", m,y).order('id DESC')
    @count = @archive.count
    render 'shared/archive'
  
  end
  
  
  get :show, :with =>:id, :protect => false, :user_only => true  do 
    @post = Post.find_by_slug(params[:id])
    @t = Time.parse(@post.created_at.to_s)
    @title = @post.title
    @comments = Comment.where("post_id = #{@post.id}").paginate(:page=>params[:page],:page => 1, 
                                                :per_page=>20).order('id DESC')

    render 'blog/show'
  end

  
  
  get :home, :protect => false, :map => '/' do
    if is_pjax?
      render :layout => false
    end
    session[:since] ||= Time.now.to_s
    #posts  = Post.find(:all, :limit=> 20, :order=>'id desc')
    #@posts = Padrino.cache.get('posts')
   #dotenv values 
    #.tr('^A-Za-z0-9','')
    #@@post_months = posts.group_by{ |t|t.created_at.beginning_of_month }  
 
    #@@post_months =Post.select("DATE_TRUNC('month', created_at) AS month,DATE_TRUNC('year', created_at)").group('month, year')
#@@post_months = Post.select("date_part('year', created_at) as y, date_part('month', created_at) as m")#.group("y", "m")
#@@post_months =  Post.limit(10).reverse
@@recipe_months =  Recipe.limit(10).reverse
@@comment_months =  Comment.limit(10).reverse


   # month = Date.strftime('%m','created_at')
    recipes  = Recipe.find(:all, :limit => 5, :order=> 'id desc')
    #@@recipe_months = recipes.group_by{|t|t.created_at.beginning_of_month }  
    #@@recipe_months = Recipe.select("date_part('year', created_at) as y, date_part('month', created_at) as m")#.group("y", "m")
    comments = Comment.find(:all,  :order=> 'id desc')
    #@@comment_months = comments.group_by{|t|t.created_at.beginning_of_month}  
     @post = Post.last
     #@date = @post.created_at.to_s.split('-').to_a
     #@day = @date[2].split(' ')
     Comment.paginate(:page => params[:page]).order('created_at DESC')
     @comments = Comment.where("post_id = #{@post.id}").paginate(:page=>params[:page],:page => 1, 
                                                :per_page=>20).order('id DESC')

    hit_increment
     render 'blog/home'
  end
  get :image, :with=>:id do
    @image = Post.find_by_slug(params[:id])
    @image.image
  end

  get :edit, :with => :id do
    @post = Post.find(params[:id])
    @title = " Post id #{@post.title } edit"
    if @post
      render 'blog/edit'
    else
      flash[:warning] = " create error #{params[:id]}"
      halt 404
    end
  end

  put :update, :with => :id  do
    image = params[:post][:image]
    upload = Upload.new
    upload = image 
    @title = pat(:update_title, :model => "post #{params[:id]}")
    @post = Post.find(params[:id])
    if @post
      if @post.update_attributes(params[:post])
        flash[:success] = " update success for blog #{params[:id]}"
        params[:save_and_continue] ?
          redirect(url(:blog, :index)) :
          redirect(url(:blog, :edit, :id => @post.id))
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
    @title = "Posts"
    post = Post.find(params[:id])
    if post
      if post.destroy
        flash[:success] = "Blog #{params[:id]}  deleted"
        redirect url(:blog, :index)
     

      else
        flash[:error] =  "delete error on Blog #{params[:id]} "
        redirect url(:blog, :index)
      end

    else
      flash[:warning] = "no such blog #{params[:id]}  delete warning"
      halt 404
    end
  end

  delete :destroy_many  do
    @title = "Posts"
    unless params[:post_ids]
      flash[:error] = "deleted many posts  error"
      redirect(url(:blog, :index))
    end
    ids = params[:post_ids].split(',').map(&:strip)
    posts = Post.find(ids)
    
    if Post.destroy posts
      flash[:success] = " successfully destroyed #{ids.to_sentence} blogs"
    end
    redirect url(:blog, :index)
  end
end
