module ApplicationHelper
  def gravatar_for(user, options = { size: 80 })
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.username, class: "img-circle")
  end
  
  def profile_pic(user)
    if user.photo.file?
      image_tag user.photo.url(:thumb), class: "img-circle"
    else
      image_tag 'missingProf.png', class: "img-circle", style: "width: 100px; height: 100px"
    end
  end
  
end
