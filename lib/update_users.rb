##################################################################################
#                                                                                #
# Created by: Jacob Mziya (BHT Software Developer)                               #
# Description: Update users with valid corresponding ta, village & district id   #
# Created on: February 13th, 2018                                                #
#                                                                                #
##################################################################################

def update_users
	users = [['admin','Mtema 1'],
	['jacob','Kanyoza']
	]
	
	(users || []).each do |user|
		username = user[0]
		village_name = user[1]
		user_village = Village.find_by_name(village_name)
		user_district = District.find_by_name('Lilongwe')
		
		user_update = User.find(username)
		user_update.district_id = user_district.id
		user_update.ta_id = user_village.ta_id
		user_update.village_id = user_village.id
		user_update.save
		
		puts "Username #{user} updated successfully \n"
	end
end

update_users