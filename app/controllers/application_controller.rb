class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?



  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :username
  end

  
  def access_denied!
    # TODO: implent access denied page
    render_404

    # respond_to do |format|

    #   format.html {render Rails.root.join("public", "404.html"), layout: false, :status => :unauthorized}
    #   format.json {render :status => :unauthorized, :text => "Access Denied"}
    # end
  end

  def render_404
    render file: Rails.root.join("public", "404"), layout: false, status: "404"
  end
  
end
