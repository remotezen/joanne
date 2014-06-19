Warden::Strategies.add(:password) do
  def valid?
    params["email"] || params["password"]
  end

  def prohibited?
    session['count'].to_i < 4
  end

  def authenticate!
     if account = Account.authenticate(params["email"], params["password"])
       session[:name] = account.user_name
      session["count"] = 0 unless session["count"].nil?
      account.nil? ? fail!("Could not log in") : success!(account)
       redirect! '/' 
    else
    if  session["count"].nil?
      session["count"] = 1
    else  
      session["count"] = session["count"].to_i + 1
    end
     prohibited? ? (redirect! 'login') : (redirect! 'banned')
    end
  end
end
Warden::Manager.serialize_into_session { |account| account.id }
Warden::Manager.serialize_from_session { |id| Account.find(id) }
