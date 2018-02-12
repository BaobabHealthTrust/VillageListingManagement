# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


districts = {}
location_tags = []

CSV.foreach("#{Rails.root}/app/assets/data/health_facilities.csv", :headers => true) do |row|
  district_name = row[0] ; facility_name = row[3]
  facility_code = row[2] ; district_code = row[1]
  region = row[4].split(' ')[0] rescue nil
  facility_type = row[5] ; description = row[6]
  facility_location = row[7] ; latitude = row[8] ; longitude = row[9]
  next if district_name.blank?
  region = 'Southern' if region.match(/south/i)
  district_name = "Nkhata-bay" if district_name.match(/nkhata/i)

  location_tags << row[5]
  districts[district_name] = [] if districts[district_name].blank?
  districts[district_name] << [
                                district_code,facility_code,
                                facility_name,region,facility_type,
                                description,facility_location,
                                latitude, longitude
                              ]
end

puts "Creating districts ...."
(districts.keys || []).each do |district_name|
  district = District.find_by_name(district_name.capitalize)
  if district.blank?
    district = District.new()
    district.name = district_name.capitalize
    district.district_code = districts[district_name].first[0]
    district.region =  districts[district_name].first[3]
    district.save
    puts "Created a new district: #{district.name} >> Code: #{district.district_code}"
  end
end
##########################################################################################



districts_with_ta_and_villages = {}
district_ta_and_villages_json = JSON.parse(`cat #{Rails.root}/app/assets/data/districts.json`)

(district_ta_and_villages_json || {}).each do |raw_district_name, ta_and_thier_villages|
  if raw_district_name.match(/-/)
    district_name = raw_district_name.strip.capitalize
  else
    district_name = raw_district_name.strip
  end
  puts "setting up TAs and villages for .......... #{district_name}"

  district = District.find_by_name(district_name)

  if district.blank?
    parent_district = 'Lilongwe' if district_name.match(/Lilongwe/i)
    parent_district = 'Blantyre' if district_name.match(/Blantyre/i)
    parent_district = 'Mzimba' if district_name.match(/Mzuzu/i)
    parent_district = 'Zomba' if district_name.match(/Zomba/i)

    new_district = District.new()
    new_district.name = district_name
    new_district.district_code = districts[parent_district].first[0] + 'C'
    new_district.region =  districts[parent_district].first[3]
    new_district.save
    puts "Created a new district: #{new_district.name} >> Code: #{new_district.district_code}"
    district = new_district
  end

  districts_with_ta_and_villages[district.name] = {} if districts_with_ta_and_villages[district.name].blank?
  (district_ta_and_villages_json[district.name].keys || []).each do |ta_name|
    districts_with_ta_and_villages[district.name][ta_name] = [] if districts_with_ta_and_villages[district.name][ta_name].blank?
    (district_ta_and_villages_json[district.name][ta_name] || []).each do |village_name|
      districts_with_ta_and_villages[district.name][ta_name] << village_name
    end
  end


end

(districts_with_ta_and_villages || {}).each_with_index do |(district_name, ta_and_villages), i|
  district = District.find_by_name(district_name)
  (ta_and_villages || {}).each do |ta, villages|

    traditional_authority = TraditionalAuthority.create(name: ta, district_id: district.id)

    (villages || []).each_with_index do |village_name, i|
      village = Village.create(name: village_name, ta_id: traditional_authority.id)
      puts "#{village_name} <<<<<<<<<<<<<<<<<<<<<<<<<<<<<  #{district_name}"
    end
  end
end

#####################################################################################################################


#####################################################################################################################
CSV.foreach("#{Rails.root}/app/assets/data/countries.csv", :headers => true).each_with_index do |row, i|
  Country.create(name: row[1], code: row[0])
end
#####################################################################################################################

puts 'Sample user Tracker'

UserTracker.create(person_tracker: 'sample_tracker',
                   username: 'sample_username')

#-------------------------------------------------------------------------
puts "Creating default user"
user = User.find('admin')
if user.blank?
	user = User.new()
	user.username = "admin"
	user.password_hash = "letmein"
	user.first_name = "Systm"
	user.last_name = "Administrator"
	user.role = "admin"
	user.gender = "M"
	user.district_id = District.find_by_name('Lilongwe').id
	user.ta_id = TraditionalAuthority.find_by_name('Mtema').id
	user.village_id = Village.find_by_name('Kanyoza').id
	user.save
  puts "User created succesfully!"
else
  puts "User already exists"
end

puts "Login: username: admin password: letmein"

