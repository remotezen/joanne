Blog::App.controllers :search do
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
  post :create do
    @title = "Jo Goes Green Search Results"
    q  = params[:search]
    #@search = Post.find(:all, :conditions => ["body like  ? or title like ?", "%#{q}","%#{q}"] ).page(params[:page]).per_page(10)
    #@search = Post.find(:all, :conditions => ["body like  ? or title like ?", q,q] ).page(params[:page]).per_page(10)
   # @search = Post.find(:all, :conditions => ["lower(body) like  lower(?) or lower(title) like lower(?)","%#{q}%", "%#{q}%"] ).page(params[:page]).per_page(10)
    #if is_user? 
      #@search1 = Post.find(:all,:conditions => ["lower(body) like  lower(?) or lower(title) like lower(?)","%#{q}%","%#{q}%"])
     # @search1 = Post.where('title like ?',q)
      @search1 = Post.where{sift :title_or_body_contains, q}
      #@search2 =  Recipe.find(:all,:conditions => ["lower(main_ingredient) like  lower(?) or lower(title) like lower(?)","%#{q}%","%#{q}%"])
      #@search1 << @search2
      @search = @search1.paginate(:page=>params[:page], :per_page=>10)  
=begin     
    elsif is_admin?  
      @search1 = Post.find(:all,:conditions => ["lower(body) like  lower(?) or lower(title) like lower(?)","%#{q}%","%#{q}%"])
      @search2 =  Recipe.find(:all,:conditions => ["lower(main_ingredient) like  lower(?) or lower(title) like lower(?)","%#{q}%","%#{q}%"])
      @search3 =   Account.find(:all,:conditions => ["lower(user_name) like  lower(?) or lower(email) like lower(?)","%#{q}%","%#{q}%"])
      @search4 =   Comment.find(:all,:conditions => ["lower(comment) like  lower(?) or lower(slug) like lower(?)","%#{q}%","%#{q}%"])
      @search5 = @search1 + @search2 + @search3 + @search4
      @search5.sort_by(&:created_at).paginate(:page => params[:page], :per_page=>10)  
    end
=end    

    render 'search/search'

#@search = ThinkingSphinx.search params[:search], :classes => [Post, Comment, Recipe]
=begin
    @search = ThinkingSphinx.search params[:search],
      :page=> params[:page], :per_page => 9, 
      :classes => [Post, Comment, Recipe]
=end      

  end    
  get :create  do

    @title = "Jo Goes Green Search results page #{params[:page] }"
=begin    
    q  = params[:search]
    @search = Post.find(:all, :conditions => ["body like  ? or title like ?",q,q])
    render 'search/search'
    @search = Post.find(:all, :conditions => ["body like  ? or title like ?", q,q] )
    render 'search/search'
=end    

#@search = ThinkingSphinx.search params[:search], :classes => [Post, Comment, Recipe]
=begin    #
    @search = ThinkingSphinx.search params[:search],
      :page=> params[:page], :per_page => 9, 
      :classes => [Post, Comment, Recipe]
=end      
    @search = Post.paginate(:page => params[:page],:per_page=>10).order("id DESC")
    render 'search/search'    

  end    
  get :admin_search_new, :protect => true  do
    render 'search/admin_search_new', :layout => :admin
  end  
  post :admin_search_create, :protect => true do
    @t = params[:table]
    q = params[:search]
    if @t == 'posts'
     @results = Post.where{sift :title_or_body_contains, q}
    elsif @t =='recipes'
     @results = Recipe.where{sift :course_or_content_or_ingredient,q} 
    elsif @t == 'comments'
     @results = Comment.where{sift :or_comment,q}
    elsif @t == 'accounts'
     @results = Account.where{sift :user_name_or_surname_or_name_or_role, q}
    end
    render 'search/post'
  end
  

end
