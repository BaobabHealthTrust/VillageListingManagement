def start  
	evr_root = ARGV[0].gsub(/\/$/, '')
	
 	if !File.exist?("#{Rails.root}/log/lastseen")
    Dir.mkdir "#{Rails.root}/log/lastseen"
  end

  if !File.exist?("../lastseennews")
    Dir.mkdir "../lastseennews"
  end

	User.all.each do |user|
		district, ta, village = [
															District.find(user.district_id).name.downcase.gsub(/\s+/, '_'),
															TraditionalAuthority.find(user.ta_id).name.downcase.gsub(/\s+/, '_'),
															Village.find(user.village_id).name.downcase.gsub(/\s+/, '_')			
														]
		file_name = "#{evr_root}/log/lastseen/#{district}__#{ta}__#{village}"
		FileUtils.touch file_name		 
	end
end

puts "Iniializing process"
start

puts "Done!"
