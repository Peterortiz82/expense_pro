module ApplicationHelper

  def mobile_device?
    if session[:mobile_param]
      session[:mobile_param] == "1"
    else
      request.user_agent =~ /Mobile|webOS/
    end
  end

  def human_boolean(boolean)
    boolean ? "Yes" : "No"
  end

end
