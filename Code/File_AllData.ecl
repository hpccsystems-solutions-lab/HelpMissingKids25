EXPORT File_AllData := MODULE
EXPORT unemp_rates := RECORD
    STRING Year;
    STRING Jan;
    STRING Feb;
    STRING Mar;
    STRING Apr;
    STRING May;
    STRING Jun;
    STRING Jul;
    STRING Aug;
    STRING Sep;
    STRING Oct;
    STRING Nov;
    STRING Dec;
END; 
EXPORT unemp_ratesDS := DATASET('~adam24::us_unemploymentrates',unemp_rates,CSV(HEADING(1)));

EXPORT unemp_byCounty := RECORD
    STRING FIPS_Code;
    STRING State;
    STRING Area_Name;
    STRING Attribute;
    STRING Value;
END;

EXPORT unemp_byCountyDS := DATASET('~adam24::unemployment',unemp_byCounty,CSV(HEADING(1)));

EXPORT pov_estimates := RECORD
    STRING FIPS_Code;
    STRING Stabr;
    STRING Area_name;
    STRING Attribute;
    STRING Value;
END;

EXPORT pov_estimatesDS := DATASET('~adam24::povertyestimates',pov_estimates,CSV(HEADING(1)));

EXPORT Education := RECORD
    STRING FIPS_Code; //Federal_Information_Processing_Standard
    STRING State;
    STRING Area_name;
    STRING Attribute;
    STRING Value;
END;

EXPORT EducationDS := DATASET('~adam24::education',education,CSV(HEADING(1)));

EXPORT pop_estimates := RECORD
    STRING FIPStxt;
    STRING State;
    STRING Area_Name;
    STRING Attribute;
    STRING Value;
END;

EXPORT pop_estimatesDS := DATASET('~adam24::populationestimates',pop_estimates,CSV(HEADING(1)));

//NCMEC Data
EXPORT mc_byState := RECORD
  UNSIGNED2 RecID;
  STRING    DatePosted;
  STRING    FullName;
  UNSIGNED1 CurrentAge;
  STRING    DateMissing;
  STRING    MissingCity;
  STRING2   MissingState;
  STRING    Contact;
  STRING    PhotoLink;
END;

EXPORT mc_byStateDS := DATASET('~adam24::ncmecbystate',mc_byState,CSV(HEADING(1)));

//https://hifld-geoplatform.opendata.arcgis.com/datasets/geoplatform::national-shelter-system-facilities

EXPORT ShelterRec := RECORD
    STRING ___X;
    STRING Y;
    STRING shelter_id;
    STRING shelter_name;
    STRING address_1;
    STRING city;
    STRING county_parish;
    STRING fips_code;
    STRING state;
    STRING zip;
    STRING mail_addr_same_as_phys_addr;
    STRING mailing_address_1;
    STRING mailing_address_2;
    STRING mailing_city;
    STRING mailing_county_parish;
    STRING mailing_state;
    STRING mailing_zip;
    STRING facility_usage_code;
    STRING evacuation_capacity;
    STRING post_impact_capacity;
    STRING ada_compliant;
    STRING wheelchair_accessible;
    STRING pet_accommodations_code;
    STRING pet_accommodations_desc;
    STRING generator_onsite;
    STRING self_sufficient_electricity;
    STRING latitude;
    STRING longitude;
    STRING in_100_yr_floodplain;
    STRING in_500_yr_floodplain;
    STRING in_surge_slosh_area;
    STRING pre_landfall_shelter;
    STRING shelter_code;
    STRING org_organization_id;
    STRING org_organization_name;
    STRING org_main_phone;
    STRING org_fax;
    STRING org_email;
    STRING org_hotline_phone;
    STRING org_other_phone;
    STRING org_address;
    STRING org_city;
    STRING org_state;
    STRING org_zip;
    STRING org_poc_name;
    STRING org_poc_phone;
    STRING org_poc_after_hours_phone;
    STRING org_poc_email;
    STRING org_hours_of_operation;
    STRING population_code;
    STRING incident_id;
    STRING shelter_status_code;
    STRING shelter_open_date;
    STRING shelter_closed_date;
    STRING reporting_period;
    STRING general_population;
    STRING medical_needs_population;
    STRING other_population;
    STRING other_population_description;
    STRING total_population;
    STRING pet_population;
    STRING incident_number;
    STRING incident_name;
    STRING incident_code;
    STRING objectid;
    STRING score;
    STRING status;
    STRING match_type;
    STRING loc_name;
    STRING geox;
    STRING geoy;
    STRING facility_type;
    STRING subfacility_code;
    STRING data_source_id;
END;

EXPORT ShelterDS := DATASET('~adam24::shelters',ShelterRec,CSV(HEADING(1)));

EXPORT CitiesRec := RECORD
    STRING city;
    STRING city_ascii;
    STRING state_id;
    STRING state_name;
    STRING county_fips;
    STRING county_name;
    STRING lat;
    STRING lng;
    STRING population;
    STRING density;
    STRING source;
    STRING military;
    STRING incorporated;
    STRING timezone;
    STRING ranking;
    STRING zips;
    STRING id;
END;

EXPORT City_DS := DATASET('~adam24::uscities',citiesrec,CSV(HEADING(1)));

END;