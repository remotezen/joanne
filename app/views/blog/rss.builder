# app/views/posts/index.rss.builder
xml.instruct!
xml.rss "version" => "2.0", "xmlns:dc" => "http://purl.org/dc/elements/1.1/" do
  xml.channel do
    xml.title "Inspiration Eating Blog News Feed"
    xml.description "Joanne Hall's Blogs"
    xml.link url_for(:posts, :index)

    for post in @posts
      xml.item do
        xml.title post.title
        xml.description post.body
        xml.pubDate post.created_at.to_s(:rfc822)
        xml.link url_for(:posts, :show, :id => post)
      end
    end
  end
end
