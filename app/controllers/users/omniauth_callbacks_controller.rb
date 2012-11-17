class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def passthru
    render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
  end

  def failure
    # @@@@@ TODO: 2 redirects here, so we're losing the flash.
    # This redirect is handled by RACK, so we don't have the 
    # flash available.
    flash[:error] = "LDAP Login failed"
    redirect_to user_omniauth_authorize_path(:LDAP)
  end

  def ldap_login
    @user = User.new
    render :ldap_login
  end

  def create
    auth = request.env["omniauth.auth"]
    @user = User.find_for_ldap_oauth(auth)
    if @user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "LDAP"
      sign_in_and_redirect @user, :event => :authentication
    else
      session["devise.ldap_data"] = auth
      redirect_to new_user_registration_url
    end
  end

end