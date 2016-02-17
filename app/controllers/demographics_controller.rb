class DemographicsController < ApplicationController

  def countries
    country_name = params[:country_name]

    names = (Country.all.each || []).map do |country|
      unless country_name.blank?
        next unless country.name.match(/#{country_name}/i)
        country.name
      else
        country.name
      end
    end
    render :text => names.compact.to_json
  end

  def districts
    district_name = params[:district_name]
    region = params[:region].sub('Region','').strip

    names = (District.by_region.key(region).each || []).map do |district|
      unless district_name.blank?
        next unless district.name.match(/#{district_name}/i)
        district.name
      else
        district.name
      end
    end
    render :text => names.compact.to_json
  end

  def traditional_authorities
    district = District.find_by_name(params[:district_name])
    ta_name = params[:ta_name]

    names = (TraditionalAuthority.by_district_id.key(district.id).each || []).map do |ta|
      unless ta_name.blank?
        next unless ta.name.match(/#{ta_name}/i)
        ta.name
      else
        ta.name
      end
    end
    render :text => names.compact.to_json
  end

  def villages
    ta = TraditionalAuthority.find_by_name(params[:ta_name])
    village_name = params[:village_name]

    names = (Village.by_ta_id.key(ta.id).each || []).map do |village|
      unless village_name.blank?
        next unless village.name.match(/#{village_name}/i)
        village.name
      else
        village.name
      end
    end
    render :text => names.compact.to_json
  end

end
