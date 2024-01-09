IMPORT $;
AD := $.File_AllData;

OUTPUT(AD.unemp_ratesDS,NAMED('US_UnempByMonth'));
OUTPUT(AD.unemp_byCountyDS,NAMED('Unemployment'));
OUTPUT(AD.EducationDS,NAMED('Education'));
OUTPUT(AD.pov_estimatesDS,NAMED('poverty'));
OUTPUT(AD.pop_estimatesDS,NAMED('Population'));
OUTPUT(AD.ShelterDS,NAMED('Shelters'));
OUTPUT(AD.mc_byStateDS,NAMED('NCMEC'));
OUTPUT(AD.City_DB,NAMED('Cities'));
OUTPUT(COUNT(AD.City_DB),NAMED('Cities_Cnt'));