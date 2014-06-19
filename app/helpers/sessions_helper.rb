Blog::App.helpers do
 
 def set_cookie
   cookie[:count] ||= cookie[:count] = 0
 end
 
 def cookie_return
   cookie[:count].to_i
 end
 
 
 def store_location
  cookie[:where] = request.referer
 end
 def where_was
  cookie[:where]
 end
 def incr_cookie
   count = cookie[:count].to_i
  cookie[:count] = count + 1
 end
 ##########################################
# Translate a given word for padrino admin
      #
      # ==== Examples
      #
      #   # => t("padrino.admin.profile",  :default => "Profile")
      #   pat(:profile)
      #
      #   # => t("padrino.admin.profile",  :default => "My Profile")
      #   pat(:profile, "My Profile")
      #
      def blog_app_translate(word, default=nil)
        t("blog.app.#{word}", :default => (default || word.to_s.humanize))
      end
      alias :pat :blog_app_translate
 
      ##
      # Translate attribute name for the given model
      #
      # ==== Examples
      #
      #   # => t("models.account.email", :default => "Email")
      #   mat(:account, :email)
      #
      def model_attribute_translate(model, attribute)
        t("models.#{model}.#{attribute}", :default => attribute.to_s.humanize)
      end
      alias :mat :model_attribute_translate
 
      ##
      # Translate model name
      #
      # ==== Examples
      #
      #   # => t("models.account.name", :default => "Account")
      #   mt(:account)
      #
      def model_translate(model)
        t("models.#{model}.name", :default => model.to_s.humanize)
      end
      alias :mt :model_translate

  def tag_icon(icon, tag = nil)
    content = content_tag(:span, '', 
    :class=> "glyphicon glyphicon-#{icon} tope")
    content << " #{tag}"
  end
def humanize
    ActiveSupport::Inflector.humanize(self)
  end


  def humanize(lower_case_and_underscored_word, options = {})
    result = lower_case_and_underscored_word.to_s.dup
    inflections.humans.each { |(rule, replacement)| break if result.sub!(rule, replacement) }
    result.gsub!(/_id$/, "")
    result.tr!('_', ' ')
    result.gsub!(/([a-z\d]*)/i) { |match|
      "#{inflections.acronyms[match] || match.downcase}"
    }
    result.gsub!(/^\w/) { |match| match.upcase } if options.fetch(:capitalize, true)
    result
  end
  def is_admin?
      current_user.role == 'admin' unless current_user.nil?
    end
      
      
  def is_user?
      (current_user.role == 'user' || current_user.role == 'admin') unless current_user.nil?
  end
  def banned?
    unless session['count'].nil?
      session['count'].to_i > 3
   end
  end
  def return_referer
    redirect_to session[:http_referer]
  end
  def store_referer
   session[:http_referer] = request.env["HTTP_REFERER"]
  end
  def soft_redirect
    flash[:error] = "Users must log in to see this page"
    redirect_to session[:http_referer]
  end
  
  def hard_redirect
    halt 404
  end
  
  def hit_increment
    req = Rack::Request.new(env)
    count = last_hit 
    hit = Counter.new( {:hit => count, :ip => req.ip} )
    if hit.save
      session[:ip].nil? ?  hit.increment!(:hit) : session[:ip] = req.ip
    else  
      nil
    end
  end
  
  def last_hit
    unless Counter.last.nil?
      count = Counter.last.hit 
    else
     count = 0 
    end
  end
  
  def is_bot?(user_agent)
    ua = AgentOrange::UserAgent.new(user_agent)
    device = ua.device
    device.is_bot?
  end
  
  def set_posts_cache
    @posts  = Post.find(:all, :limit=> 20, :order=>'id desc')
    Padrino.cache.set('posts', @posts)
  end
  
  def delete_posts_cache
    Padrino.cache.delete('posts')
  end
  def gone
    session.clear unless logged_in?
  end
end
