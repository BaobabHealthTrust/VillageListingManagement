##################################################################################
#                                                                                #
# Created by: Jacob Mziya (BHT Software Developer)                               #
# Description: Update users with valid corresponding ta, village & district id   #
# Created on: February 13th, 2018                                                #
#                                                                                #
##################################################################################

def update_users
	users = ['admin']
	
	(users || []).each do |user|
		user_update = User.find(user)
		user_update.district_id = '8a72179c27706e6629b893d080a27de4'
		user_update.ta_id = '8a72179c27706e6629b893d080be06b9'
		user_update.village_id = '637e932be893478e1367880cae7065d5'
		user_update.save
		
		puts "Username #{user} updated successfully \n"
	end
end

update_users