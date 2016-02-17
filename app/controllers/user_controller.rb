class UserController < ApplicationController
  def login
  end

  def remote_login
    user = User.find(params[:user]['username'])
    if user
      if user.password_matches?(params[:user]['password'])
        user_obj = {username: user.username,first_name: user.first_name,
                    last_name: user.last_name, role: user.role,
                    ta: TraditionalAuthority.find(user.ta_id).name,
                    village: Village.find(user.village_id).name,
                    district: District.find(user.district_id).name,
                    authenticity_token: params[:authenticity_token]
                   }
        AuthenticityToken.create(token: params[:authenticity_token], username: user.username)
        render :text => user_obj.to_json and return
      end
    end
    render :text => [].to_json
  end

  def usernames
    render :text => [].to_json
  end

end
