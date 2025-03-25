//Import:ecl:Code.CrashCourse.BubbleEx
//To run this example, you need to have the Visualization bundle installed.
//See: https://github.com/hpcc-systems/Visualizer
IMPORT Visualizer;

GamesRec := RECORD
    STRING Rank;
    STRING Name;
    STRING Platform;
    STRING Year;
    STRING Genre;
    STRING Publisher;
    STRING NA_Sales;
    STRING EU_Sales;
    STRING JP_Sales;
    STRING Other_Sales;
    STRING Global_Sales;
END;

Games_DS := DATASET('~tech::vgsales',GamesRec,CSV(HEADING(1)));
top_sales_Count := TOPN(TABLE(Games_DS,{name,Global_Sales}),10,-Global_Sales);
OUTPUT(top_sales_Count,NAMED('salescount'));
Visualizer.TwoD.Bubble('global_count',,'salescount');
//Import:ecl:Code.CrashCourse.FunctionEx
myfunc (STRING val) := FUNCTION
  Result := 'Hello ' + val + ' , welcome to this function';
  RETURN Result;
END;

//Using myfunc
res := myfunc('Trish');
OUTPUT(res, NAMED('FunctionResult'));

OUTPUT(myfunc('George'),NAMED('GeorgeTest'));

//Single line function:
MaxVal(SET OF INTEGER numlist) := MAX(numlist);
OUTPUT(MaxVal([2,5,8,10,45,11]),NAMED('CheckMax'));
//Import:ecl:Code.CrashCourse.InlineEx
IMPORT $;

SalaryAvg_Layout := RECORD 
    STRING  Job;
    STRING  Category;
    STRING  City;
    STRING2 State;
    INTEGER Avg_Salary;
END;

//Inline Dataset
SalaryAvg_DS := DATASET([
{'Manager','IT', 'Atlanta', 'GA', 87000},
{'Director','Art','Atlanta','GA',100000},
{'CIO','IT','Tampa','FL',112000},
{'Sales','General','Chicago','IL',55000}
], SalaryAvg_Layout);

// A simple output
OUTPUT(SalaryAvg_DS,NAMED('SalaryAvg_DS'));

//CHOOSEN
OUTPUT(CHOOSEN(SalaryAvg_DS,2),NAMED('SalaryAvg_Choosen'));

//Filter
OUTPUT(SalaryAvg_DS(City = 'Tampa'),NAMED('Tampa_Filter'));

//Sort
SortJobs := SORT(SalaryAvg_DS, Job);
OUTPUT(SortJobs, NAMED('SortJobs'));
//Import:ecl:Code.CrashCourse.InlineTransformEx
Person_Layout := RECORD
  INTEGER PersonID;
  STRING FirstName;
  STRING LastName;
END;

NameDS := DATASET([
                  {100,'Jo','Smith'},
                  {203,'Dan','Carpenter'},
                  {498,'Sally','Fryman'},
                  {302,'Silver','Rose'}
                  ],Person_Layout);

NameOutRec := RECORD
  UNSIGNED1 RecCount;
  INTEGER   PersonID;
  STRING    PersonName;
  STRING    FutureAddress;
END;                    

CatRecs := PROJECT(nameDS, 
                   TRANSFORM(NameOutRec,
                     SELF.PersonName := LEFT.FirstName + ' ' + LEFT.LastName;
                     SELF.RecCount   := COUNTER;
                     SELF            := LEFT;
                     SELF            := [];
                   ));
               
OUTPUT(CatRecs, NAMED('Inline_CatRecs'));                   
//Import:ecl:Code.CrashCourse.JOINEx
EMP_Layout   := {INTEGER EmpID,STRING Name,INTEGER HireYear};
JobCatLayout := {INTEGER EmpID,STRING Department,STRING Title};

EmpDS := DATASET([
                 {1000,'Jack',2014},
                 {2000,'Blue',2016},
                 {3000,'Mary',2016},
                 {5000,'Marty',2000},
                 {8000,'Cat',2002}
                 ],EMP_Layout);

JobCatDS := DATASET([
                    {1000,'IT','Developer'},
                    {2000,'Biz','Manager'},
                    {4000,'Fin','Accountant'},
                    {8000,'IT','Analyst'}
                    ],JobCatLayout);

InnerJoin := JOIN(EmpDS,JobCatDS,
                  LEFT.EmpID=RIGHT.EmpID);

LeftOuterJoin := JOIN(EmpDS,JobCatDS,
                  LEFT.EmpID=RIGHT.EmpID,
                  LEFT OUTER);

FullOuterJoin := JOIN(EmpDS,JobCatDS,
                  LEFT.EmpID=RIGHT.EmpID,
                  FULL OUTER);

OUTPUT(InnerJoin);
OUTPUT(LeftOuterJoin);
OUTPUT(FullOuterJoin);                                     
//Import:ecl:Code.CrashCourse.MATHEx
Mathlayout := RECORD
  INTEGER Num1;
  INTEGER Num2;
  INTEGER Num3;
END;

DS := DATASET([
                {20,45,34},
                {909,56,45},
                {30,-1,90}
              ],MathLayout);

COUNT(DS);               //Counts the number of records in the dataset -- Returns 3
MAX(DS,Num1);            //Returns the maximum value on a field in the dataset -- Returns 909
MIN(DS,Num2);            //Returns the minimum value on a field in the dataset -- Returns -1
AVE(DS,Num1);            //Returns the average value on a field in the dataset -- Returns 319.6666666666667
SUM(DS, Num1 + Num3);    //Returns the result of adding numbers together -- Returns 1128
TRUNCATE(AVE(DS,Num1));  //Returns the interger portion of the real value. -- 319
ROUND(3.45);             //Returns the rounded value -- Return 3
ROUND(3.76);             //Returns the rounded value -- Return 4


//Import:ecl:Code.CrashCourse.MyMod
EXPORT myMod := MODULE
 //Visible only by MyMod
 SHARED x := 88;
 SHARED y := 42;

 //Visible by MyMod and externally
 EXPORT See := 'This is how a module works';
 EXPORT Res := Y * 2;
END;
//Import:ecl:Code.CrashCourse.RunMyMod
IMPORT $;
OUTPUT($.MyMod.See,NAMED('Message'));
OUTPUT($.MyMod.Res,NAMED('Result'));


//Import:ecl:Code.CrashCourse.TableEx
Pickup_layout := RECORD
  STRING10   pickup_date;
  DECIMAL8_2 fare;
  DECIMAL8_2 distance;
END;

Pickup_DS := DATASET([
                     {'2015-01-01',25.10,5},
                     {'2015-01-01',40.15,8},
                     {'2015-01-02',30.10,6},
                     {'2015-01-02',25.15,4}
                     ], Pickup_Layout);

crossTabLayout := RECORD
  Pickup_DS.pickup_date;
  avgFare := AVE(GROUP,Pickup_DS.fare);
  totFare := SUM(GROUP,Pickup_DS.fare);
END;

crossTabDS := TABLE(Pickup_DS, // Input Dataset
                    crossTabLayout,
                    pickup_date);

OUTPUT(crossTabDS, NAMED('crossTabs'));                    
//Import:ecl:Code.CrashCourse.TransformEx
Person_Layout := RECORD
  STRING FirstName;
  STRING LastName;
END;

NameDS := DATASET([
                  {'Sun','Shine'},
                  {'Blue','Moon'},
                  {'Silver','Rose'}
                  ],Person_Layout);

NameOutRec := RECORD
  STRING15  FirstName;
  STRING15  LastName;
  STRING15  CatValues;
  UNSIGNED1 RecCount;
END;                    

NameOutRec CatThem(Person_Layout Le,INTEGER Ct) := TRANSFORM
  SELF.CatValues := TRIM(Le.FirstName) + ' ' + Le.LastName;
  SELF.RecCount  := Ct;
  SELF           := Le;
END;

CatRecs := PROJECT(nameDS, //dataset to loop through
                   CatThem //Transform name
                   (LEFT,  //Left dataset which is nameDS
                   COUNTER //Simple Counter
                   ));

OUTPUT(CatRecs, NAMED('CatRecs'));                   
//Import:ecl:Code.BWR_AllInputData
IMPORT $;
HMK := $.File_AllData;

OUTPUT(HMK.unemp_ratesDS,NAMED('US_UnempByMonth'));
OUTPUT(HMK.unemp_byCountyDS,NAMED('Unemployment'));
OUTPUT(HMK.EducationDS,NAMED('Education'));
OUTPUT(HMK.pov_estimatesDS,NAMED('Poverty'));
OUTPUT(HMK.pop_estimatesDS,NAMED('Population'));
OUTPUT(HMK.PoliceDS,NAMED('Police'));
OUTPUT(HMK.FireDS,NAMED('Fire'));
OUTPUT(HMK.HospitalDS,NAMED('Hospitals'));
OUTPUT(HMK.ChurchDS,NAMED('Churches'));
OUTPUT(HMK.FoodBankDS,NAMED('FoodBanks'));
OUTPUT(HMK.mc_byStateDS,NAMED('NCMEC'));
OUTPUT(COUNT(HMK.mc_byStateDS),NAMED('NCMEC_Cnt'));
OUTPUT(HMK.City_DS,NAMED('Cities'));
OUTPUT(COUNT(HMK.City_DS),NAMED('Cities_Cnt'));


//Import:ecl:Code.BWR_CleanChurches
IMPORT $,STD;
//This file is used to demonstrate how to "clean" a raw dataset (Churches) and create an index to be used in a ROXIE service
Churches := $.File_AllData.ChurchDS;
Cities   := $.File_AllData.City_DS;


//First, determine what fields you want to clean:
CleanChurchRec := RECORD
    STRING70  name;
    STRING35  street;
    STRING22  city;
    STRING2   state;
    UNSIGNED3 zip;
    UNSIGNED1 affiliation; 
    UNSIGNED3 PrimaryFIPS; //New - will be added from Cities DS
END;
//PROJECT is used to transform one data record to another.
CleanChurch := PROJECT(Churches,TRANSFORM(CleanChurchRec,
                                          SELF.name                := STD.STR.ToUpperCase(LEFT.name),
                                          SELF.street              := STD.STR.ToUpperCase(LEFT.street),
                                          SELF.city                := STD.STR.ToUpperCase(LEFT.city),
                                          SELF.State               := STD.STR.ToUpperCase(LEFT.state),
                                          SELF.zip                 := LEFT.zip,
                                          SELF.affiliation         := LEFT.affiliation,
                                          SELF.PrimaryFIPS         := 0));
//JOIN is used to combine data from different datasets 
CleanChurchFIPS :=       JOIN(CleanChurch,Cities,
                           LEFT.city  = STD.STR.ToUpperCase(RIGHT.city) AND
                           LEFT.state = RIGHT.state_id,
                           TRANSFORM(CleanChurchRec,
                                     SELF.PrimaryFIPS := (UNSIGNED3)RIGHT.county_fips,
                                     SELF             := LEFT),LEFT OUTER,LOOKUP);
//Write out the new file and then define it using DATASET
WriteChurches      := OUTPUT(CleanChurchFIPS,,'~HMK::OUT::Churches',NAMED('WriteDS'),OVERWRITE);                                          
CleanChurchesDS    := DATASET('~HMK::OUT::Churches',CleanChurchRec,FLAT);

//Declare and Build Indexes (special datasets that can be used in the ROXIE data delivery cluster
CleanChurchIDX     := INDEX(CleanChurchesDS,{city,state},{CleanChurchesDS},'~HMK::IDX::Church::CityPay');
CleanChurchFIPSIDX := INDEX(CleanChurchesDS,{PrimaryFIPS},{CleanChurchesDS},'~HMK::IDX::Church::FIPSPay');
BuildChurchIDX     := BUILD(CleanChurchIDX,NAMED('BldIDX1'),OVERWRITE);
BuildChurchFIPSIDX := BUILD(CleanChurchFIPSIDX,NAMED('BLDIDX2'),OVERWRITE);

//Cross-Tab Reports:
//Churches by City: 

CT_City := TABLE(CleanChurchesDS,{city,state,cnt := COUNT(GROUP)},state,city);
Out_CT_City := OUTPUT(SORT(CT_City,-cnt),NAMED('ChurchByCity'));

//Cross-Tab by State:

CT_ST := TABLE(CleanChurchesDS,{state,cnt := COUNT(GROUP)},state);
Out_CT_ST := OUTPUT(SORT(CT_ST,-cnt),NAMED('ChurchByState'));

//Cross-Tab by Primary FIPS:

CT_FIPS := TABLE(CleanChurchesDS,{PrimaryFIPS,cnt := COUNT(GROUP)},PrimaryFIPS);
Out_CT_FIPS := OUTPUT(SORT(CT_FIPS(PrimaryFIPS <> 0),-cnt),NAMED('ChurchByFIPS'));

//SEQUENTIAL is similar to OUTPUT, but executes the actions in sequence instead of the default parallel actions of the HPCC
SEQUENTIAL(WriteChurches,BuildChurchIDX,BuildChurchFIPSIDX,out_Ct_City,Out_Ct_ST,Out_CT_FIPS);



//Import:ecl:Code.Codes
// POVALL_2021	Estimate of people of all ages in poverty 2021
// CI90LBALL_2021	90 percent confidence interval lower bound of estimate of people of all ages in poverty 2021
// CI90UBALL_2021	90 percent confidence interval upper bound of estimate of people of all ages in poverty 2021
// PCTPOVALL_2021	Estimated percent of people of all ages in poverty 2021
// CI90LBALLP_2021	90 percent confidence interval lower bound of estimate of percent of people of all ages in poverty 2021
// CI90UBALLP_2021	90 percent confidence interval upper bound of estimate of percent of people of all ages in poverty 2021
// POV017_2021	Estimate of people age 0-17 in poverty 2021
// CI90LB017_2021	90 percent confidence interval lower bound of estimate of people age 0-17 in poverty 2021
// CI90UB017_2021	90 percent confidence interval upper bound of estimate of people age 0-17 in poverty 2021
// PCTPOV017_2021	Estimated percent of people age 0-17 in poverty 2021
// CI90LB017P_2021	90 percent confidence interval lower bound of estimate of percent of people age 0-17 in poverty 2021
// CI90UB017P_2021	90 percent confidence interval upper bound of estimate of percent of people age 0-17 in poverty 2021
// POV517_2021	Estimate of related children age 5-17 in families in poverty 2021
// CI90LB517_2021	90 percent confidence interval lower bound of estimate of related children age 5-17 in families in poverty 2021
// CI90UB517_2021	90 percent confidence interval upper bound of estimate of related children age 5-17 in families in poverty 2021
// PCTPOV517_2021	Estimated percent of related children age 5-17 in families in poverty 2021
// CI90LB517P_2021	90 percent confidence interval lower bound of estimate of percent of related children age 5-17 in families in poverty 2021
// CI90UB517P_2021	90 percent confidence interval upper bound of estimate of percent of related children age 5-17 in families in poverty 2021
// MEDHHINC_2021	Estimate of median household income 2021
// CI90LBINC_2021	90 percent confidence interval lower bound of estimate of median household income 2021
// CI90UBINC_2021	90 percent confidence interval upper bound of estimate of median household income 2021
// POV04_2021	Estimate of children ages 0 to 4 in poverty 2021 (available for the U.S. and State total only)
// CI90LB04_2021	90 percent confidence interval lower bound of estimate of children ages 0 to 4 in poverty 2021 (available for the U.S. and State total only)
// CI90UB04_2021	90 percent confidence interval upper bound of estimate of children ages 0 to 4 in poverty 2021 (available for the U.S. and State total only)
// PCTPOV04_2021	Estimated percent of children ages 0 to 4 in poverty 2021 (available for the U.S. and State total only)
// CI90LB04P_2021	90 percent confidence interval lower bound of estimate of percent of children ages 0 to 4 in poverty 2021 (available for the U.S. and State total only)
// CI90UB04P_2021	90 percent confidence interval upper bound of estimate of percent of children ages 0 to 4 in poverty 2021 (available for the U.S. and State total only)
//Import:ecl:Code.File_AllData
EXPORT File_AllData := MODULE
//The datasets proivided in this challenge are all in the public domain and free for you to use. 
//The links to the downloads and specific license info is provided below.


//Unemployment Rates
//Not used in challenge, just interesting info!
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
EXPORT unemp_ratesDS := DATASET('~hmk::in::us_unemploymentrates',unemp_rates,CSV(HEADING(1)));

//https://www.ers.usda.gov/data-products/county-level-data-sets/county-level-data-sets-download-data/
//Unemployment stats from 2000-2021
EXPORT unemp_byCounty := RECORD
    UNSIGNED3 FIPS_Code;
    STRING2   State;
    STRING50  Area_Name;
    STRING45  Attribute;
    REAL8     Value;
END;

EXPORT unemp_byCountyDS := DATASET('~hmk::in::unemployment',unemp_byCounty,CSV(HEADING(1)));

EXPORT pov_estimates := RECORD
    UNSIGNED3 FIPS_Code;
    STRING2   State;
    STRING35  Area_name;
    STRING35  Attribute;
    REAL8     Value;
END;

EXPORT pov_estimatesDS := DATASET('~hmk::in::poverty',pov_estimates,CSV(HEADING(1)));

EXPORT Education := RECORD
    UNSIGNED3 FIPS_Code; //Federal_Information_Processing_Standard
    STRING2   State;
    STRING45  Area_name;
    STRING75  Attribute;
    REAL8     Value;
END;

EXPORT EducationDS := DATASET('~hmk::in::education',education,CSV(HEADING(1)));

EXPORT pop_estimates := RECORD
    UNSIGNED3 FIPS_Code;
    STRING2   State;
    STRING50  Area_Name;
    STRING35  Attribute;
    REAL8     Value;
END;

EXPORT pop_estimatesDS := DATASET('~hmk::in::population',pop_estimates,CSV(HEADING(1)));

//NCMEC Data
//Source:
//https://www.missingkids.org/gethelpnow/search/rss
//data extracted from RSS feeds from original XML format to composite CSV
//Best Records were added from the original import data - instructor will show process
EXPORT mc_byState := RECORD
  UNSIGNED3 RecID;
  STRING11  DatePosted;
  STRING18  FirstName;
  STRING24  LastName;
  UNSIGNED1 CurrentAge;
  UNSIGNED4 DateMissing;
  STRING25  MissingCity;
  STRING2   MissingState;
  STRING150 Contact;
  STRING100 PhotoLink;
END;

EXPORT mc_byStateDS := DATASET('~hmk::IN::ncmecbystate',mc_byState,CSV(HEADING(1)));
// EXPORT mc_byStateDS := DATASET('~HMK::EXPORT::NCMECByState2-2',mc_byState,CSV(HEADING(1)));

//https://hifld-geoplatform.opendata.arcgis.com/datasets/

//Fire Stations
//Available for public use. 
//None. Acknowledgement of the USGS is appreciated. This dataset is provided as is and intended for general mapping purposes. 
//The information contained in these data are dynamic and could change over time. USGS makes no warranty about content accuracy 
//or currentness of the data and assumes no liability for use of this data. 
//User assumes responsibility for appropriate use and interpretation of the dataset.
EXPORT FireRec := RECORD
    REAL8     Xcoor;
    REAL8     Ycoor;
    UNSIGNED3 objectid;
    STRING40  permanent_identifier;
    STRING30  source_featureid;
    STRING40  source_datasetid;
    STRING50  source_datadesc;
    STRING85  source_originator;
    UNSIGNED1 data_security;
    STRING2   distribution_policy;
    STRING25  loaddate;
    UNSIGNED2 ftype;
    UNSIGNED3 fcode;
    STRING100 name;
    UNSIGNED1 islandmark;
    UNSIGNED1 pointlocationtype;
    UNSIGNED1 admintype;
    STRING60  addressbuildingname;
    STRING65  address;
    STRING35  city;
    STRING2   state;
    STRING10  zipcode;
    UNSIGNED4 gnis_id;
    STRING    foot_id;
    STRING    complex_id;
    STRING38  globalid;
END;

EXPORT FireDS := DATASET('~hmk::in::Fire',FireRec,CSV(HEADING(1)));

//Local Law Enforcement Locations in US
//https://hifld-geoplatform.opendata.arcgis.com/datasets/local-law-enforcement-locations/explore
//License: None (Public Use). 
//Users are advised to read the data set's metadata thoroughly to understand appropriate use and data limitations.
EXPORT PoliceRec := RECORD
    REAL8     xCoor;
    REAL8     yCoor;
    UNSIGNED3 objectid;
    UNSIGNED4 id;
    STRING135 name;
    STRING80  address;
    STRING30  city;
    STRING2   state;
    STRING5   zip;
    STRING15  zip4;
    STRING15  telephone;
    STRING25  type;
    STRING15  status;
    INTEGER3  population;
    STRING25  county;
    STRING5   countyfips;
    STRING3   country;
    REAL8     latitude;
    REAL8     longitude;
    UNSIGNED3 naics_code;
    STRING20  naics_desc;
    STRING145 source;
    STRING25  sourcedate;
    STRING15  val_method;
    STRING25  val_date;
    STRING155 website;
    STRING15  ci_id;
    INTEGER4  csllea08id;
    INTEGER2  subtype1;
    INTEGER2  subtype2;
    INTEGER2  tribal;
    INTEGER2  numpre;
    INTEGER2  numfixsub;
    INTEGER2  nummobile;
    INTEGER3  ftsworn;
    INTEGER3  ftciv;
    INTEGER2  ptsworn;
    INTEGER2  ptciv;
END;

EXPORT PoliceDS := DATASET('~hmk::in::Police',PoliceRec,CSV(HEADING(1)));

EXPORT HospitalRec := RECORD
    REAL8     xCoor;
    REAL8     yCoor;
    UNSIGNED2 objectid;
    STRING10  id;
    STRING95  name;
    STRING80  address;
    STRING35  city;
    STRING2   state;
    STRING5   zip;
    STRING15  zip4;
    STRING15  telephone;
    STRING20  type;
    STRING6   status;
    INTEGER2  population;
    STRING20  county;
    STRING5   countyfips;
    STRING3   country;
    REAL8     latitude;
    REAL8     longitude;
    UNSIGNED3 naics_code;
    STRING70  naics_desc;
    STRING165 source;
    STRING22  sourcedate;
    STRING13  val_method;
    STRING22  val_date;
    STRING206 website;
    STRING15  state_id;
    STRING110 alt_name;
    STRING2   st_fips;
    STRING31  owner;
    INTEGER2  ttl_staff;
    INTEGER2  beds;
    STRING45  trauma;
    STRING15  helipad;
END;

EXPORT HospitalDS := DATASET('~hmk::in::Hospitals',HospitalRec,CSV(HEADING(1)));

//Cities Database
//Free Version: https://simplemaps.com/data/us-cities
//
EXPORT CitiesRec := RECORD
    STRING45  city;
    STRING45  city_ascii;
    STRING2   state_id;
    STRING20  state_name;
    STRING5   county_fips;
    STRING30  county_name;
    REAL4     lat;
    REAL8     lng;
    UNSIGNED4 population;
    REAL4     density;
    STRING5   source;
    STRING5   military;
    STRING5   incorporated;
    STRING30  timezone;
    UNSIGNED1 ranking;
    STRING1855 zips;
    UNSIGNED5 id;
END;

EXPORT City_DS := DATASET('~hmk::in::uscities',citiesrec,CSV(HEADING(1)));

//MORE DATA FROM Homeland Infrastructure Foundation-Level Data (HIFLD)
// https://hifld-geoplatform.opendata.arcgis.com/datasets/geoplatform::all-places-of-worship/explore
//Places of Worship

EXPORT ChurchRec := RECORD
    UNSIGNED3 ___objectid;
    UNSIGNED5 ein;
    STRING70 name;
    STRING35 street;
    STRING22 city;
    STRING2 state;
    UNSIGNED3 zip;
    UNSIGNED1 affiliation;
    UNSIGNED3 ruling;
    UNSIGNED1 foundation;
    UNSIGNED5 activity;
    UNSIGNED1 organization;
    UNSIGNED3 tax_period;
    UNSIGNED1 acct_pd;
    STRING13 ntee_cd;
    STRING13 sort_name;
    STRING13 loc_name;
    STRING1 geocoded_status;
    REAL8 score;
    STRING1 match_type;
    STRING75 match_addr;
    STRING13 addr_type;
    STRING13 addnum;
    STRING13 side;
    STRING13 stpredir;
    STRING19 stpretype;
    STRING29 stname;
    STRING13 sttype;
    STRING13 stdir;
    STRING37 staddr;
    STRING30 city_2;
    STRING23 subregion;
    STRING20 region;
    STRING13 regionabbr;
    STRING13 postal;
    STRING3 country;
    STRING13 langcode;
    UNSIGNED1 distance;
    REAL8 x;
    REAL8 y;
    REAL8 displayx;
    REAL8 displayy;
    REAL8 xmin;
    REAL8 xmax;
    REAL8 ymin;
    REAL8 ymax;
    STRING13 addnumfrom;
    STRING13 addnumto;
    STRING13 rank;
    STRING35 arc_address;
    STRING22 arc_city;
    STRING2 arc_region;
    UNSIGNED3 arc_postal;
END;

EXPORT ChurchDS := DATASET('~hmk::in::churches',churchrec,CSV(HEADING(1)));

//FEMA: 
//https://gis-fema.hub.arcgis.com/datasets/da001dee68474719b934a166f7abdc46/explore
//Food banks
EXPORT FoodBankRec := RECORD
    REAL8 ___x;
    REAL8 y;
    UNSIGNED1 fema_region;
    STRING63 food_bank_name;
    UNSIGNED2 member_number;
    STRING42 address;
    STRING16 city;
    STRING2 state;
    STRING10 zip_code;
    STRING60 web_page;
    STRING100 facebook_page;
    UNSIGNED2 fid;
    STRING11 status;
    STRING36 globalid;
END;

EXPORT FoodBankDS := DATASET('~hmk::in::foodbanks',foodbankrec,CSV(HEADING(1)));
END;
//Import:ecl:Code.TestMeHello
OUTPUT('Hello Hackers!');
