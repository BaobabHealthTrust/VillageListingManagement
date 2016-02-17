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
    #usernames = User.where("username LIKE(?)", "%#{params[:search_string]}%").map(&:username)
    str_length = params[:search_string].length
    usernames = User.all.each.map do |user|
      if str_length > 0
        next if user.username[0..str_length] != params[:search_string]
        user.username
      else
        user.username
      end
    end
    render :text => usernames.to_json
  end

  def first_names
    str_length = params[:search_string].length
    names = (User.all.each || []).map do |user|
      if str_length > 0
        next if user.first_name[0..str_length] != params[:search_string]
        user.first_name
      else
        user.first_name
      end
    end
    render :text => names.to_json
  end

  def last_names
    str_length = params[:search_string].length
    names = (User.all.each || []).map do |user|
      if str_length > 0
        next if user.last_name[0..str_length] != params[:search_string]
        user.last_name
      else
        user.last_name
      end
    end
    render :text => names.to_json
  end

  def create
    username = params[:new_user]['username']
    password =  params[:new_user]['password']
    first_name =  params[:new_user]['first_name']
    last_name =  params[:new_user]['last_name']
    role =  params[:new_user]['role']
    district_id =  District.find_by_name(params[:user]['district']).id
    ta_id =  TraditionalAuthority.find_by_name(params[:user]['ta']).id
    village_id = Village.find_by_name(params[:user]['village']).id

    user = User.create(username: username, password_hash: password,
      first_name: first_name, last_name: last_name, role: role, creator: params[:user]['username'],
      district_id: district_id, ta_id: ta_id, village_id: village_id)

    render :text => user.to_json and return
  end

end
