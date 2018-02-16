##################################################################################
#                                                                                #
# Created by: Jacob Mziya (BHT Software Developer)                               #
# Description: Update users with valid corresponding ta, village & district id   #
# Created on: February 13th, 2018                                                #
#                                                                                #
##################################################################################

def update_users
	users = [['adoni','Biwi'],
	['biwi','Biwi'],
	['dyton','Biwi'],
	['bwalo','Bwalo 1'],
	['bwalo2','Bwalo 2'],
	['bwatha','Bwatha'],
	['zunguzeni','Bwatha'],
	['chagamba','Chagamba'],
	['kelvin','Chagamba'],
	['chakale','Chakala'],
	['chalasa','Chalasa'],
	['chaonya','Chaonya'],
	['kenivasi','Chaonya'],
	['chidalanda','Chidalanda'],
	['gilbert','Chidalanda'],
	['chembekezo','Chidzele'],
	['chigo','Chikamba'],
	['chikamba','Chikolokoto'],
	['abisoni','Chimphepo'],
	['chimphepo','Chimphepo'],
	['salimoni','Chimphepo'],
	['chisomba','Chisomba'],
	['rose','Chisomba'],
	['biliyati','Chitawa'],
	['liana','Chitawa'],
	['rihanna','Chitawa'],
	['chithengo','Chithengo'],
	['yoki','Chithengo'],
	['chitululu','Chitululu'],
	['chizumba','Chizumba'],
	['chule','Chule 1'],
	['kathumba','Chule 1'],
	['rodiwelo','Chule 1'],
	['chule2','Chule 2'],
	['kambizeni','Chule 2'],
	['dongo','Dongolosi'],
	['dongolosi','Dongolosi'],
	['fainda','Fainda'],
	['yolamu','Fainda'],
	['beatrice','Kabzyoko'],
	['kabzoko','Kabzyoko'],
	['kacheche','Kacheche'],
	['esawo','Kalulu'],
	['kamadzi','Kamadzi'],
	['steve','Kamadzi'],
	['kambira','Kambiri'],
	['kambulire','Kambulire 1'],
	['kambulire2','Kambulire 2'],
	['sankhani','Kambulire 2'],
	['kamphinga','Kamphinga'],
	['kaninga','Kaninga'],
	['kondwani','Kaninga'],
	['kanyoza','Kanyoza'],
	['bazale','Kanyoza'],
	['lotale','Kazinkambani'],
	['kholongo','Kholongo'],
	['david',"M’maso"],
	['davie',"M’maso"],
	['mayikolo','Malenga'],
	['mankhwazi','Mankhwazi'],
	['jenet','Maole'],
	['maole','Maole'],
	['maselero','Maselero'],
	['charles','Masumba'],
	['masumba','Masumba'],
	['weluzani','Masumba'],
	['matchakaza','Matchakaza'],
	['william','Matchakaza'],
	['mawunda','Maunda'],
	['mazira','Mazira'],
	['kazimkambani','Mbalame'],
	['mbalame','Mbalame'],
	['mblame','Mbalame'],
	['mbewa','Mbewa'],
	['mbulachisa','Mbulachisa'],
	['kasakula','Mchena'],
	['mchena','Mchena'],
	['nchazime','Mchezime'],
	['henry','Mdzoole'],
	['mdzoole','Mdzoole'],
	['mfuti','Mfuti'],
	['mgwadula','Mgwadula'],
	['misewu','Misewo'],
	['mkupeta','Mkupeta'],
	['mmaso','Mmaso'],
	['brino','Mndele'],
	['mphandu','Mphandu'],
	['mphonde','Mphonde'],
	['mseteza','Mseteza'],
	['jackson','Mtema 1'],
	['makombe','Mtema 1'],
	['mtema1','Mtema 1'],
	['fredrick','Mtema 2'],
	['mtsukwachikupa','Mtsukwa Chikupa'],
	['mtsukwakalonje','Mtsukwa Kalonje'],
	['mutu','Mutu'],
	['mwaza','Mwaza'],
	['mtsatsula','Mzingo'],
	['hezekia','Mzumanzi 1'],
	['mzumazi2','Mzumanzi 2'],
	['nzumazi2','Mzumanzi 2'],
	['nzumazi','Mzumazi 1'],
	['ndalama','Ndalama'],
	['ngoza','Ngoza'],
	['sitima','Ngoza'],
	['nkhadani1','Nkhadani 1'],
	['nkhadani2','Nkhadani 2'],
	['nkhanamba','Nkhanamba'],
	['konkha','Nkhonkha'],
	['amosi','Nkhutchi'],
	['chisisi','Nkhutchi'],
	['andrew','Nkhutchi'],
	['ezala','Nsanda'],
	['ezara','Nsanda'],
	['nsanda','Nsanda'],
	['pheleni','Pheleni'],
	['laston','Suntche 1'],
	['suntche1','Suntche 1'],
	['jonathani','Suntche 1'],
	['boston','Suntche 2'],
	['suntche2','Suntche 2'],
	['jonas','Taiza'],
	['kwimbayani','Taiza'],
	['taiza','Taiza'],
	['joseph','Wayakumseche']]
	
	#-----------------------------
	
	(users || []).each do |user|
		username = user[0]
		village_name = user[1]
		user_village = Village.find_by_name(village_name)
		next if user_village.nil?
		
		user_district = District.find_by_name('Lilongwe')
		
		user_update = User.find(username)
		next if user_update.nil?
		
		user_update.district_id = user_district.id
		user_update.ta_id = user_village.ta_id
		user_update.village_id = user_village.id
		user_update.save
		
		puts "Username #{user} updated successfully \n"
	end
end

update_users