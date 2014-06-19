# Helper methods defined here can be accessed in any controller or view in the application
Blog::App.helpers do

def cycle
    @_cycle ||= reset_cycle
    @_cycle = [@_cycle.pop] + @_cycle
    @_cycle.first
  end

  def reset_cycle
    @_cycle = %w(even odd)
  end
  # def simple_helper_method
  # end
  def post_date(post)
    raw = post.created_at
    date  = raw.to_s.split('-')
    day_month = date[2].split(' ')
    month = return_month(date[1])
    hash = { :day => day_month[0], 
             :month => month,
             :year  => date[0]
           }
    main = {
            :blog_date => hash,
            :time_ago => " posted #{time_ago_in_words(raw)} ago"
            }
    partial 'shared/calender', :locals => { :h => main}
  end
  
  def return_month(mon)

    month = case mon.to_i
        when 1 then "January"
        when 2 then " Feburary"
        when 3 then "March"
        when 4 then "April"
        when 5 then "May"
        when 6 then "June"
        when 7 then "July"
        when 8 then "August"
        when 9 then "September"
        when 10 then "October"
        when 11 then "Novemeber"  
        when 12 then "December"  
        else "no such month"
        end
   return month
 end
  
  
  
  def link_to_image(img, path)
    link_to image_tag(img.to_s), path
  end
  
  def tag_icon(icon, tag = nil)
            content = content_tag(:i, '', :class=> "icon-#{icon.to_s}")
            content << " #{tag.to_s}"
  end

  def gravatar_for( user, options = {})
      options[:size] ||=15
      gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
      gravatar_url = "http://gravatar.com/avatar/#{gravatar_id}.png"
      image_tag(gravatar_url, alt: user.name, class: "gravatar", 
                width: options[:size])
  end

  def gravatar_for_nil(options = {})
      options[:size] ||=15
      gravatar_url = "http://gravatar.com/avatar"
      image_tag(gravatar_url, alt: "John Doe", class: "gravatar", 
                width: options[:size])
    end

    def app_title(t=nil)
      if t.nil?
        title = "Jo Goes Green"
      else
        title = t
      end 
      simple_format(title, :tag => :div,  :class => "admin-title")
    end

  def post_archived(amount=10)
    Post.order(by: month).limit(amount)
    models = model.group_by{ |t| t.created_at.beginning_of_month}
  end 
  
  def _klass(classname)
  Kernel.const_get(classname).methods
  end
  def archive(date)
    str = date.to_s
    a = str.split('-')
    s = "#{return_month(a[1])}" + " "  + "#{a[0]}"
    
  end
  def split_date(date)
    s1 = date.to_s.split(" ").to_a
    s1[0]
  end
  def geo_hash(geo)
    hash = { 
      :lat => geo["latitude"],
      :long  => geo["longitude"],
    }
  end
  def distance_between(h1,h2)
    lat1 = h1[:lat]
    long1= h1[:long] 
    lat2 = h2[:lat]
    long2= h2[:long] 
    long = long1 - long2
    lat = lat1  - lat2
    Geocoder::Calculations.distance_between([lat1,long1],[lat2,long2])
  end
  def geo(ip)
    searched = Geocoder.search(ip).first.data unless Geocoder.search(ip) == nil
    if searched == nil
      return nil
    else
     geo_hash(searched)
    end


    end
  def distance(d1,d2)
    distance_between(d1,d2)
  end
def tag_icon(icon, tag = nil)
  content = content_tag(:i, '', :class=> "icon-#{icon}")
  content << " #{tag}"
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
def flashed
  partial 'shared/flash'
end

  def title(&block)
    haml_tag :div, :class =>"title" do 
      yield if block_given?
    end
  end
end


