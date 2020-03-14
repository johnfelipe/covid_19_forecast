# Time-series based 7-days ahead forecasts of (known) confirmed cases of the novel Coronavirus COVID-19 (2019-nCoV)

**Statement**: This is just "hobby" project and forecast results *should not* be taken too seriously! Even though forecast performance may be reasonable for some country and some period in time. Don't take the numbers forecast as granted!
This project is mainly supposed to show what may be realized (without too much effort) with the open-source statistics and econometrics software gretl (URL: http://gretl.sourceforge.net/).

**An automated job** retrives latest data at 3am (CET), trains a new model, computes the forecasts and uploads the new forecasting plots here to my github-repo. The overall job finishes in about 15 seconds on a Raspberry Pi 4 computer --- this is just an amazing piece of hardware ;-)

## Data source
Data provided by the Johns Hopkins University Center for Systems Science and Engineering (JHU CCSE) can be found here:
https://github.com/CSSEGISandData/COVID-19

## Some words on the underlying model
I want to keep it simple. If you fancy, you can use the current state of code as a starting point for devloping and evaluating more complex approaches. However, the ARIMA type of model applied may already provide a reasonable approach for modelling and computing short-term contagion dynamics. *Gretl's* built-in ```arima``` command is used for this.

The default model is an ARIMA(1,2,0) specification (every textbook covering time-seres has a chapter on this traditional approach). We've choosen twice differencing in order to capture the exponential trend visibile in many countries during the high-time period.
In case the maximum-likelihood estimator does not converge, an ARIMA(0,2,0) will be estimated. If this specification also fails to converge a simple ARIMA(0,1,0) will be tried. For countries showing no contagion dynamics (yet), we simly interpolate the historic average.

## Forecasting method
We compute out-of-sample multi-period interval forecasts. The multi-period forecast is recursively computed. Per default the 90 % forecast (Gaussian) interval will be shown as well.

## The gretl script
The gretl script for setting up relevant things and executing the analysis is ```./script/run.inp```.

At the beginning of the script, the user can specify the following parameters:
```
string DIR_WORK = "" 		# <SET_PATH_HERE> e.g. "/home/git_project"
string DATA_URL = "https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_19-covid-Confirmed.csv"	# Data source
string INITIAL_DATE = "2020-01-22"			# 1st available observation of CSSE dataset
scalar MAX_HORIZON = 7					# maximum multi-step OoS forecast horizon
scalar RUN_EXPOST_ANALYSIS = 0				# run expost forecasting exercise, by going 'MAX_HORIZON' back in time
scalar COMPILE_MARKDOWN_CMD = 1				# compile markdown command for inserting forecasting plots to README.md

# ARIMA model settings
scalar ARIMA_P = 1					# autoregressive (AR) order
scalar ARIMA_D = 2					# differencing order
scalar ARIMA_Q = 0					# moving average (MA) order
```

This script will also load the functions doing the main stuff in the beckground which are stored in ```./src/helper.inp```.

The gretl script can be executed in the following ways:
Option A:

	1) Clone the repo by means of ```git clone```
	2) open the script "./script/run.inp"
	3) Set your project path by setting the variable "DIR_WORK" accordingly.
	4) Execute and enjoy.

Option B (works for linux):

	1) Clone the repo by means of ```git clone```
	2) Execute the shell-script run.sh

## What does the script do?
The script downloads latest available CCSE-data, processes the raw data for obtaining a clean panel data set.
Next, for each country-province combination two exercises are conducted:

	1) If the parameter ```RUN_EXPOST_ANALYSIS``` is set to '1' , an **ex-post** forecasting analysis is done. For this,  the training-set is set to <CURRENT_DATE - MAX_HORIZON> observations where "CURRENT_DATE" refers to latest date for which data is available, and ```MAX_HORIZON``` is the set multi-step forecast horizon (default 7 days).
	2) Out-of-sample interval forecasts for the forthcoming ```MAX_HORIZON``` days are computed.

# Ex-Post and up-to-date out-of-sample 7-days ahead forecasts
The left panel shows forecast made in information available 7 days ago and the realization of 'confirmed cases' during this period. This may give you an idea of how 'well' the forecasted dynamics were. 

The right panel shows forecasts made on latest data for the forthcoming 7 days.

<img src="./figures/forecast_maxhorizon_7_thailand__expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_thailand_.png" width="425"/>
<em>thailand - </em>

<img src="./figures/forecast_maxhorizon_7_japan__expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_japan_.png" width="425"/>
<em>japan - </em>

<img src="./figures/forecast_maxhorizon_7_singapore__expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_singapore_.png" width="425"/>
<em>singapore - </em>

<img src="./figures/forecast_maxhorizon_7_nepal__expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_nepal_.png" width="425"/>
<em>nepal - </em>

<img src="./figures/forecast_maxhorizon_7_malaysia__expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_malaysia_.png" width="425"/>
<em>malaysia - </em>

<img src="./figures/forecast_maxhorizon_7_canada_british_columbia_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_canada_british_columbia.png" width="425"/>
<em>canada - british_columbia</em>

<img src="./figures/forecast_maxhorizon_7_australia_new_south_wales_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_australia_new_south_wales.png" width="425"/>
<em>australia - new_south_wales</em>

<img src="./figures/forecast_maxhorizon_7_australia_victoria_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_australia_victoria.png" width="425"/>
<em>australia - victoria</em>

<img src="./figures/forecast_maxhorizon_7_australia_queensland_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_australia_queensland.png" width="425"/>
<em>australia - queensland</em>

<img src="./figures/forecast_maxhorizon_7_cambodia__expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_cambodia_.png" width="425"/>
<em>cambodia - </em>

<img src="./figures/forecast_maxhorizon_7_sri_lanka__expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_sri_lanka_.png" width="425"/>
<em>sri_lanka - </em>

<img src="./figures/forecast_maxhorizon_7_germany__expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_germany_.png" width="425"/>
<em>germany - </em>

<img src="./figures/forecast_maxhorizon_7_finland__expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_finland_.png" width="425"/>
<em>finland - </em>

<img src="./figures/forecast_maxhorizon_7_united_arab_emirates__expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_united_arab_emirates_.png" width="425"/>
<em>united_arab_emirates - </em>

<img src="./figures/forecast_maxhorizon_7_philippines__expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_philippines_.png" width="425"/>
<em>philippines - </em>

<img src="./figures/forecast_maxhorizon_7_india__expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_india_.png" width="425"/>
<em>india - </em>

<img src="./figures/forecast_maxhorizon_7_italy__expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_italy_.png" width="425"/>
<em>italy - </em>

<img src="./figures/forecast_maxhorizon_7_sweden__expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_sweden_.png" width="425"/>
<em>sweden - </em>

<img src="./figures/forecast_maxhorizon_7_spain__expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_spain_.png" width="425"/>
<em>spain - </em>

<img src="./figures/forecast_maxhorizon_7_australia_south_australia_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_australia_south_australia.png" width="425"/>
<em>australia - south_australia</em>

<img src="./figures/forecast_maxhorizon_7_belgium__expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_belgium_.png" width="425"/>
<em>belgium - </em>

<img src="./figures/forecast_maxhorizon_7_egypt__expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_egypt_.png" width="425"/>
<em>egypt - </em>

<img src="./figures/forecast_maxhorizon_7_australia_from_diamond_princess_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_australia_from_diamond_princess.png" width="425"/>
<em>australia - from_diamond_princess</em>

<img src="./figures/forecast_maxhorizon_7_lebanon__expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_lebanon_.png" width="425"/>
<em>lebanon - </em>

<img src="./figures/forecast_maxhorizon_7_iraq__expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_iraq_.png" width="425"/>
<em>iraq - </em>

<img src="./figures/forecast_maxhorizon_7_oman__expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_oman_.png" width="425"/>
<em>oman - </em>

<img src="./figures/forecast_maxhorizon_7_afghanistan__expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_afghanistan_.png" width="425"/>
<em>afghanistan - </em>

<img src="./figures/forecast_maxhorizon_7_bahrain__expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_bahrain_.png" width="425"/>
<em>bahrain - </em>

<img src="./figures/forecast_maxhorizon_7_kuwait__expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_kuwait_.png" width="425"/>
<em>kuwait - </em>

<img src="./figures/forecast_maxhorizon_7_algeria__expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_algeria_.png" width="425"/>
<em>algeria - </em>

<img src="./figures/forecast_maxhorizon_7_croatia__expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_croatia_.png" width="425"/>
<em>croatia - </em>

<img src="./figures/forecast_maxhorizon_7_switzerland__expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_switzerland_.png" width="425"/>
<em>switzerland - </em>

<img src="./figures/forecast_maxhorizon_7_austria__expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_austria_.png" width="425"/>
<em>austria - </em>

<img src="./figures/forecast_maxhorizon_7_israel__expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_israel_.png" width="425"/>
<em>israel - </em>

<img src="./figures/forecast_maxhorizon_7_pakistan__expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_pakistan_.png" width="425"/>
<em>pakistan - </em>

<img src="./figures/forecast_maxhorizon_7_brazil__expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_brazil_.png" width="425"/>
<em>brazil - </em>

<img src="./figures/forecast_maxhorizon_7_georgia__expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_georgia_.png" width="425"/>
<em>georgia - </em>

<img src="./figures/forecast_maxhorizon_7_greece__expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_greece_.png" width="425"/>
<em>greece - </em>

<img src="./figures/forecast_maxhorizon_7_north_macedonia__expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_north_macedonia_.png" width="425"/>
<em>north_macedonia - </em>

<img src="./figures/forecast_maxhorizon_7_norway__expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_norway_.png" width="425"/>
<em>norway - </em>

<img src="./figures/forecast_maxhorizon_7_romania__expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_romania_.png" width="425"/>
<em>romania - </em>

<img src="./figures/forecast_maxhorizon_7_estonia__expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_estonia_.png" width="425"/>
<em>estonia - </em>

<img src="./figures/forecast_maxhorizon_7_netherlands__expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_netherlands_.png" width="425"/>
<em>netherlands - </em>

<img src="./figures/forecast_maxhorizon_7_san_marino__expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_san_marino_.png" width="425"/>
<em>san_marino - </em>

<img src="./figures/forecast_maxhorizon_7_belarus__expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_belarus_.png" width="425"/>
<em>belarus - </em>

<img src="./figures/forecast_maxhorizon_7_iceland__expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_iceland_.png" width="425"/>
<em>iceland - </em>

<img src="./figures/forecast_maxhorizon_7_lithuania__expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_lithuania_.png" width="425"/>
<em>lithuania - </em>

<img src="./figures/forecast_maxhorizon_7_mexico__expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_mexico_.png" width="425"/>
<em>mexico - </em>

<img src="./figures/forecast_maxhorizon_7_new_zealand__expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_new_zealand_.png" width="425"/>
<em>new_zealand - </em>

<img src="./figures/forecast_maxhorizon_7_nigeria__expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_nigeria_.png" width="425"/>
<em>nigeria - </em>

<img src="./figures/forecast_maxhorizon_7_australia_western_australia_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_australia_western_australia.png" width="425"/>
<em>australia - western_australia</em>

<img src="./figures/forecast_maxhorizon_7_ireland__expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_ireland_.png" width="425"/>
<em>ireland - </em>

<img src="./figures/forecast_maxhorizon_7_luxembourg__expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_luxembourg_.png" width="425"/>
<em>luxembourg - </em>

<img src="./figures/forecast_maxhorizon_7_monaco__expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_monaco_.png" width="425"/>
<em>monaco - </em>

<img src="./figures/forecast_maxhorizon_7_qatar__expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_qatar_.png" width="425"/>
<em>qatar - </em>

<img src="./figures/forecast_maxhorizon_7_ecuador__expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_ecuador_.png" width="425"/>
<em>ecuador - </em>

<img src="./figures/forecast_maxhorizon_7_azerbaijan__expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_azerbaijan_.png" width="425"/>
<em>azerbaijan - </em>

<img src="./figures/forecast_maxhorizon_7_armenia__expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_armenia_.png" width="425"/>
<em>armenia - </em>

<img src="./figures/forecast_maxhorizon_7_dominican_republic__expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_dominican_republic_.png" width="425"/>
<em>dominican_republic - </em>

<img src="./figures/forecast_maxhorizon_7_indonesia__expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_indonesia_.png" width="425"/>
<em>indonesia - </em>

<img src="./figures/forecast_maxhorizon_7_portugal__expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_portugal_.png" width="425"/>
<em>portugal - </em>

<img src="./figures/forecast_maxhorizon_7_andorra__expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_andorra_.png" width="425"/>
<em>andorra - </em>

<img src="./figures/forecast_maxhorizon_7_australia_tasmania_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_australia_tasmania.png" width="425"/>
<em>australia - tasmania</em>

<img src="./figures/forecast_maxhorizon_7_latvia__expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_latvia_.png" width="425"/>
<em>latvia - </em>

<img src="./figures/forecast_maxhorizon_7_morocco__expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_morocco_.png" width="425"/>
<em>morocco - </em>

<img src="./figures/forecast_maxhorizon_7_saudi_arabia__expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_saudi_arabia_.png" width="425"/>
<em>saudi_arabia - </em>

<img src="./figures/forecast_maxhorizon_7_senegal__expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_senegal_.png" width="425"/>
<em>senegal - </em>

<img src="./figures/forecast_maxhorizon_7_argentina__expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_argentina_.png" width="425"/>
<em>argentina - </em>

<img src="./figures/forecast_maxhorizon_7_chile__expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_chile_.png" width="425"/>
<em>chile - </em>

<img src="./figures/forecast_maxhorizon_7_jordan__expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_jordan_.png" width="425"/>
<em>jordan - </em>

<img src="./figures/forecast_maxhorizon_7_ukraine__expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_ukraine_.png" width="425"/>
<em>ukraine - </em>

<img src="./figures/forecast_maxhorizon_7_hungary__expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_hungary_.png" width="425"/>
<em>hungary - </em>

<img src="./figures/forecast_maxhorizon_7_australia_northern_territory_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_australia_northern_territory.png" width="425"/>
<em>australia - northern_territory</em>

<img src="./figures/forecast_maxhorizon_7_liechtenstein__expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_liechtenstein_.png" width="425"/>
<em>liechtenstein - </em>

<img src="./figures/forecast_maxhorizon_7_poland__expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_poland_.png" width="425"/>
<em>poland - </em>

<img src="./figures/forecast_maxhorizon_7_tunisia__expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_tunisia_.png" width="425"/>
<em>tunisia - </em>

<img src="./figures/forecast_maxhorizon_7_bosnia_and_herzegovina__expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_bosnia_and_herzegovina_.png" width="425"/>
<em>bosnia_and_herzegovina - </em>

<img src="./figures/forecast_maxhorizon_7_slovenia__expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_slovenia_.png" width="425"/>
<em>slovenia - </em>

<img src="./figures/forecast_maxhorizon_7_south_africa__expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_south_africa_.png" width="425"/>
<em>south_africa - </em>

<img src="./figures/forecast_maxhorizon_7_bhutan__expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_bhutan_.png" width="425"/>
<em>bhutan - </em>

<img src="./figures/forecast_maxhorizon_7_cameroon__expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_cameroon_.png" width="425"/>
<em>cameroon - </em>

<img src="./figures/forecast_maxhorizon_7_colombia__expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_colombia_.png" width="425"/>
<em>colombia - </em>

<img src="./figures/forecast_maxhorizon_7_costa_rica__expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_costa_rica_.png" width="425"/>
<em>costa_rica - </em>

<img src="./figures/forecast_maxhorizon_7_peru__expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_peru_.png" width="425"/>
<em>peru - </em>

<img src="./figures/forecast_maxhorizon_7_serbia__expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_serbia_.png" width="425"/>
<em>serbia - </em>

<img src="./figures/forecast_maxhorizon_7_slovakia__expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_slovakia_.png" width="425"/>
<em>slovakia - </em>

<img src="./figures/forecast_maxhorizon_7_togo__expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_togo_.png" width="425"/>
<em>togo - </em>

<img src="./figures/forecast_maxhorizon_7_french_guiana__expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_french_guiana_.png" width="425"/>
<em>french_guiana - </em>

<img src="./figures/forecast_maxhorizon_7_malta__expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_malta_.png" width="425"/>
<em>malta - </em>

<img src="./figures/forecast_maxhorizon_7_martinique__expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_martinique_.png" width="425"/>
<em>martinique - </em>

<img src="./figures/forecast_maxhorizon_7_bulgaria__expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_bulgaria_.png" width="425"/>
<em>bulgaria - </em>

<img src="./figures/forecast_maxhorizon_7_maldives__expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_maldives_.png" width="425"/>
<em>maldives - </em>

<img src="./figures/forecast_maxhorizon_7_bangladesh__expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_bangladesh_.png" width="425"/>
<em>bangladesh - </em>

<img src="./figures/forecast_maxhorizon_7_paraguay__expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_paraguay_.png" width="425"/>
<em>paraguay - </em>

<img src="./figures/forecast_maxhorizon_7_canada_ontario_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_canada_ontario.png" width="425"/>
<em>canada - ontario</em>

<img src="./figures/forecast_maxhorizon_7_canada_alberta_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_canada_alberta.png" width="425"/>
<em>canada - alberta</em>

<img src="./figures/forecast_maxhorizon_7_canada_quebec_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_canada_quebec.png" width="425"/>
<em>canada - quebec</em>

<img src="./figures/forecast_maxhorizon_7_albania__expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_albania_.png" width="425"/>
<em>albania - </em>

<img src="./figures/forecast_maxhorizon_7_cyprus__expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_cyprus_.png" width="425"/>
<em>cyprus - </em>

<img src="./figures/forecast_maxhorizon_7_brunei__expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_brunei_.png" width="425"/>
<em>brunei - </em>

<img src="./figures/forecast_maxhorizon_7_us_washington_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_washington.png" width="425"/>
<em>us - washington</em>

<img src="./figures/forecast_maxhorizon_7_us_new_york_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_new_york.png" width="425"/>
<em>us - new_york</em>

<img src="./figures/forecast_maxhorizon_7_us_california_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_california.png" width="425"/>
<em>us - california</em>

<img src="./figures/forecast_maxhorizon_7_us_massachusetts_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_massachusetts.png" width="425"/>
<em>us - massachusetts</em>

<img src="./figures/forecast_maxhorizon_7_us_diamond_princess_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_diamond_princess.png" width="425"/>
<em>us - diamond_princess</em>

<img src="./figures/forecast_maxhorizon_7_us_grand_princess_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_grand_princess.png" width="425"/>
<em>us - grand_princess</em>

<img src="./figures/forecast_maxhorizon_7_us_georgia_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_georgia.png" width="425"/>
<em>us - georgia</em>

<img src="./figures/forecast_maxhorizon_7_us_colorado_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_colorado.png" width="425"/>
<em>us - colorado</em>

<img src="./figures/forecast_maxhorizon_7_us_florida_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_florida.png" width="425"/>
<em>us - florida</em>

<img src="./figures/forecast_maxhorizon_7_us_new_jersey_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_new_jersey.png" width="425"/>
<em>us - new_jersey</em>

<img src="./figures/forecast_maxhorizon_7_us_oregon_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_oregon.png" width="425"/>
<em>us - oregon</em>

<img src="./figures/forecast_maxhorizon_7_us_texas_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_texas.png" width="425"/>
<em>us - texas</em>

<img src="./figures/forecast_maxhorizon_7_us_illinois_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_illinois.png" width="425"/>
<em>us - illinois</em>

<img src="./figures/forecast_maxhorizon_7_us_pennsylvania_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_pennsylvania.png" width="425"/>
<em>us - pennsylvania</em>

<img src="./figures/forecast_maxhorizon_7_us_iowa_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_iowa.png" width="425"/>
<em>us - iowa</em>

<img src="./figures/forecast_maxhorizon_7_us_maryland_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_maryland.png" width="425"/>
<em>us - maryland</em>

<img src="./figures/forecast_maxhorizon_7_us_north_carolina_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_north_carolina.png" width="425"/>
<em>us - north_carolina</em>

<img src="./figures/forecast_maxhorizon_7_us_south_carolina_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_south_carolina.png" width="425"/>
<em>us - south_carolina</em>

<img src="./figures/forecast_maxhorizon_7_us_tennessee_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_tennessee.png" width="425"/>
<em>us - tennessee</em>

<img src="./figures/forecast_maxhorizon_7_us_virginia_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_virginia.png" width="425"/>
<em>us - virginia</em>

<img src="./figures/forecast_maxhorizon_7_us_arizona_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_arizona.png" width="425"/>
<em>us - arizona</em>

<img src="./figures/forecast_maxhorizon_7_us_indiana_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_indiana.png" width="425"/>
<em>us - indiana</em>

<img src="./figures/forecast_maxhorizon_7_us_kentucky_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_kentucky.png" width="425"/>
<em>us - kentucky</em>

<img src="./figures/forecast_maxhorizon_7_us_district_of_columbia_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_district_of_columbia.png" width="425"/>
<em>us - district_of_columbia</em>

<img src="./figures/forecast_maxhorizon_7_us_nevada_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_nevada.png" width="425"/>
<em>us - nevada</em>

<img src="./figures/forecast_maxhorizon_7_us_new_hampshire_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_new_hampshire.png" width="425"/>
<em>us - new_hampshire</em>

<img src="./figures/forecast_maxhorizon_7_us_minnesota_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_minnesota.png" width="425"/>
<em>us - minnesota</em>

<img src="./figures/forecast_maxhorizon_7_us_nebraska_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_nebraska.png" width="425"/>
<em>us - nebraska</em>

<img src="./figures/forecast_maxhorizon_7_us_ohio_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_ohio.png" width="425"/>
<em>us - ohio</em>

<img src="./figures/forecast_maxhorizon_7_us_rhode_island_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_rhode_island.png" width="425"/>
<em>us - rhode_island</em>

<img src="./figures/forecast_maxhorizon_7_us_wisconsin_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_wisconsin.png" width="425"/>
<em>us - wisconsin</em>

<img src="./figures/forecast_maxhorizon_7_us_connecticut_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_connecticut.png" width="425"/>
<em>us - connecticut</em>

<img src="./figures/forecast_maxhorizon_7_us_hawaii_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_hawaii.png" width="425"/>
<em>us - hawaii</em>

<img src="./figures/forecast_maxhorizon_7_us_oklahoma_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_oklahoma.png" width="425"/>
<em>us - oklahoma</em>

<img src="./figures/forecast_maxhorizon_7_us_utah_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_utah.png" width="425"/>
<em>us - utah</em>

<img src="./figures/forecast_maxhorizon_7_burkina_faso__expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_burkina_faso_.png" width="425"/>
<em>burkina_faso - </em>

<img src="./figures/forecast_maxhorizon_7_holy_see__expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_holy_see_.png" width="425"/>
<em>holy_see - </em>

<img src="./figures/forecast_maxhorizon_7_mongolia__expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_mongolia_.png" width="425"/>
<em>mongolia - </em>

<img src="./figures/forecast_maxhorizon_7_panama__expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_panama_.png" width="425"/>
<em>panama - </em>

<img src="./figures/forecast_maxhorizon_7_us_kansas_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_kansas.png" width="425"/>
<em>us - kansas</em>

<img src="./figures/forecast_maxhorizon_7_us_louisiana_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_louisiana.png" width="425"/>
<em>us - louisiana</em>

<img src="./figures/forecast_maxhorizon_7_us_missouri_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_missouri.png" width="425"/>
<em>us - missouri</em>

<img src="./figures/forecast_maxhorizon_7_us_vermont_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_vermont.png" width="425"/>
<em>us - vermont</em>

<img src="./figures/forecast_maxhorizon_7_us_alaska_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_alaska.png" width="425"/>
<em>us - alaska</em>

<img src="./figures/forecast_maxhorizon_7_us_arkansas_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_arkansas.png" width="425"/>
<em>us - arkansas</em>

<img src="./figures/forecast_maxhorizon_7_us_delaware_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_delaware.png" width="425"/>
<em>us - delaware</em>

<img src="./figures/forecast_maxhorizon_7_us_idaho_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_idaho.png" width="425"/>
<em>us - idaho</em>

<img src="./figures/forecast_maxhorizon_7_us_maine_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_maine.png" width="425"/>
<em>us - maine</em>

<img src="./figures/forecast_maxhorizon_7_us_michigan_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_michigan.png" width="425"/>
<em>us - michigan</em>

<img src="./figures/forecast_maxhorizon_7_us_mississippi_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_mississippi.png" width="425"/>
<em>us - mississippi</em>

<img src="./figures/forecast_maxhorizon_7_us_montana_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_montana.png" width="425"/>
<em>us - montana</em>

<img src="./figures/forecast_maxhorizon_7_us_new_mexico_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_new_mexico.png" width="425"/>
<em>us - new_mexico</em>

<img src="./figures/forecast_maxhorizon_7_us_north_dakota_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_north_dakota.png" width="425"/>
<em>us - north_dakota</em>

<img src="./figures/forecast_maxhorizon_7_us_south_dakota_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_south_dakota.png" width="425"/>
<em>us - south_dakota</em>

<img src="./figures/forecast_maxhorizon_7_us_west_virginia_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_west_virginia.png" width="425"/>
<em>us - west_virginia</em>

<img src="./figures/forecast_maxhorizon_7_us_wyoming_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_wyoming.png" width="425"/>
<em>us - wyoming</em>

<img src="./figures/forecast_maxhorizon_7_china_hubei_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_china_hubei.png" width="425"/>
<em>china - hubei</em>

<img src="./figures/forecast_maxhorizon_7_iran__expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_iran_.png" width="425"/>
<em>iran - </em>

<img src="./figures/forecast_maxhorizon_7_korea_south__expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_korea_south_.png" width="425"/>
<em>korea_south - </em>

<img src="./figures/forecast_maxhorizon_7_france_france_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_france_france.png" width="425"/>
<em>france - france</em>

<img src="./figures/forecast_maxhorizon_7_china_guangdong_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_china_guangdong.png" width="425"/>
<em>china - guangdong</em>

<img src="./figures/forecast_maxhorizon_7_china_henan_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_china_henan.png" width="425"/>
<em>china - henan</em>

<img src="./figures/forecast_maxhorizon_7_china_zhejiang_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_china_zhejiang.png" width="425"/>
<em>china - zhejiang</em>

<img src="./figures/forecast_maxhorizon_7_china_hunan_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_china_hunan.png" width="425"/>
<em>china - hunan</em>

<img src="./figures/forecast_maxhorizon_7_china_anhui_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_china_anhui.png" width="425"/>
<em>china - anhui</em>

<img src="./figures/forecast_maxhorizon_7_china_jiangxi_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_china_jiangxi.png" width="425"/>
<em>china - jiangxi</em>

<img src="./figures/forecast_maxhorizon_7_china_shandong_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_china_shandong.png" width="425"/>
<em>china - shandong</em>

<img src="./figures/forecast_maxhorizon_7_cruise_ship_diamond_princess_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_cruise_ship_diamond_princess.png" width="425"/>
<em>cruise_ship - diamond_princess</em>

<img src="./figures/forecast_maxhorizon_7_china_jiangsu_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_china_jiangsu.png" width="425"/>
<em>china - jiangsu</em>

<img src="./figures/forecast_maxhorizon_7_china_chongqing_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_china_chongqing.png" width="425"/>
<em>china - chongqing</em>

<img src="./figures/forecast_maxhorizon_7_china_sichuan_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_china_sichuan.png" width="425"/>
<em>china - sichuan</em>

<img src="./figures/forecast_maxhorizon_7_china_heilongjiang_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_china_heilongjiang.png" width="425"/>
<em>china - heilongjiang</em>

<img src="./figures/forecast_maxhorizon_7_denmark_denmark_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_denmark_denmark.png" width="425"/>
<em>denmark - denmark</em>

<img src="./figures/forecast_maxhorizon_7_china_beijing_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_china_beijing.png" width="425"/>
<em>china - beijing</em>

<img src="./figures/forecast_maxhorizon_7_china_shanghai_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_china_shanghai.png" width="425"/>
<em>china - shanghai</em>

<img src="./figures/forecast_maxhorizon_7_china_hebei_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_china_hebei.png" width="425"/>
<em>china - hebei</em>

<img src="./figures/forecast_maxhorizon_7_china_fujian_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_china_fujian.png" width="425"/>
<em>china - fujian</em>

<img src="./figures/forecast_maxhorizon_7_china_guangxi_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_china_guangxi.png" width="425"/>
<em>china - guangxi</em>

<img src="./figures/forecast_maxhorizon_7_china_shaanxi_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_china_shaanxi.png" width="425"/>
<em>china - shaanxi</em>

<img src="./figures/forecast_maxhorizon_7_china_yunnan_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_china_yunnan.png" width="425"/>
<em>china - yunnan</em>

<img src="./figures/forecast_maxhorizon_7_china_hainan_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_china_hainan.png" width="425"/>
<em>china - hainan</em>

<img src="./figures/forecast_maxhorizon_7_china_guizhou_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_china_guizhou.png" width="425"/>
<em>china - guizhou</em>

<img src="./figures/forecast_maxhorizon_7_china_tianjin_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_china_tianjin.png" width="425"/>
<em>china - tianjin</em>

<img src="./figures/forecast_maxhorizon_7_china_shanxi_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_china_shanxi.png" width="425"/>
<em>china - shanxi</em>

<img src="./figures/forecast_maxhorizon_7_china_gansu_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_china_gansu.png" width="425"/>
<em>china - gansu</em>

<img src="./figures/forecast_maxhorizon_7_china_hong_kong_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_china_hong_kong.png" width="425"/>
<em>china - hong_kong</em>

<img src="./figures/forecast_maxhorizon_7_china_liaoning_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_china_liaoning.png" width="425"/>
<em>china - liaoning</em>

<img src="./figures/forecast_maxhorizon_7_china_jilin_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_china_jilin.png" width="425"/>
<em>china - jilin</em>

<img src="./figures/forecast_maxhorizon_7_czechia__expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_czechia_.png" width="425"/>
<em>czechia - </em>

<img src="./figures/forecast_maxhorizon_7_china_xinjiang_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_china_xinjiang.png" width="425"/>
<em>china - xinjiang</em>

<img src="./figures/forecast_maxhorizon_7_china_inner_mongolia_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_china_inner_mongolia.png" width="425"/>
<em>china - inner_mongolia</em>

<img src="./figures/forecast_maxhorizon_7_china_ningxia_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_china_ningxia.png" width="425"/>
<em>china - ningxia</em>

<img src="./figures/forecast_maxhorizon_7_taiwan*__expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_taiwan*_.png" width="425"/>
<em>taiwan* - </em>

<img src="./figures/forecast_maxhorizon_7_vietnam__expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_vietnam_.png" width="425"/>
<em>vietnam - </em>

<img src="./figures/forecast_maxhorizon_7_russia__expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_russia_.png" width="425"/>
<em>russia - </em>

<img src="./figures/forecast_maxhorizon_7_china_qinghai_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_china_qinghai.png" width="425"/>
<em>china - qinghai</em>

<img src="./figures/forecast_maxhorizon_7_china_macau_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_china_macau.png" width="425"/>
<em>china - macau</em>

<img src="./figures/forecast_maxhorizon_7_moldova__expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_moldova_.png" width="425"/>
<em>moldova - </em>

<img src="./figures/forecast_maxhorizon_7_bolivia__expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_bolivia_.png" width="425"/>
<em>bolivia - </em>

<img src="./figures/forecast_maxhorizon_7_denmark_faroe_islands_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_denmark_faroe_islands.png" width="425"/>
<em>denmark - faroe_islands</em>

<img src="./figures/forecast_maxhorizon_7_france_st_martin_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_france_st_martin.png" width="425"/>
<em>france - st_martin</em>

<img src="./figures/forecast_maxhorizon_7_honduras__expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_honduras_.png" width="425"/>
<em>honduras - </em>

<img src="./figures/forecast_maxhorizon_7_united_kingdom_channel_islands_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_united_kingdom_channel_islands.png" width="425"/>
<em>united_kingdom - channel_islands</em>

<img src="./figures/forecast_maxhorizon_7_canada_new_brunswick_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_canada_new_brunswick.png" width="425"/>
<em>canada - new_brunswick</em>

<img src="./figures/forecast_maxhorizon_7_china_tibet_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_china_tibet.png" width="425"/>
<em>china - tibet</em>

<img src="./figures/forecast_maxhorizon_7_congo_(kinshasa)__expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_congo_(kinshasa)_.png" width="425"/>
<em>congo_(kinshasa) - </em>

<img src="./figures/forecast_maxhorizon_7_cote_d'ivoire__expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_cote_d'ivoire_.png" width="425"/>
<em>cote_d'ivoire - </em>

<img src="./figures/forecast_maxhorizon_7_france_saint_barthelemy_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_france_saint_barthelemy.png" width="425"/>
<em>france - saint_barthelemy</em>

<img src="./figures/forecast_maxhorizon_7_jamaica__expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_jamaica_.png" width="425"/>
<em>jamaica - </em>

<img src="./figures/forecast_maxhorizon_7_reunion__expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_reunion_.png" width="425"/>
<em>reunion - </em>

<img src="./figures/forecast_maxhorizon_7_turkey__expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_turkey_.png" width="425"/>
<em>turkey - </em>

<img src="./figures/forecast_maxhorizon_7_united_kingdom_gibraltar_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_united_kingdom_gibraltar.png" width="425"/>
<em>united_kingdom - gibraltar</em>

<img src="./figures/forecast_maxhorizon_7_us_kitsap_wa_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_kitsap_wa.png" width="425"/>
<em>us - kitsap_wa</em>

<img src="./figures/forecast_maxhorizon_7_us_solano_ca_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_solano_ca.png" width="425"/>
<em>us - solano_ca</em>

<img src="./figures/forecast_maxhorizon_7_us_santa_cruz_ca_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_santa_cruz_ca.png" width="425"/>
<em>us - santa_cruz_ca</em>

<img src="./figures/forecast_maxhorizon_7_us_napa_ca_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_napa_ca.png" width="425"/>
<em>us - napa_ca</em>

<img src="./figures/forecast_maxhorizon_7_us_ventura_ca_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_ventura_ca.png" width="425"/>
<em>us - ventura_ca</em>

<img src="./figures/forecast_maxhorizon_7_us_worcester_ma_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_worcester_ma.png" width="425"/>
<em>us - worcester_ma</em>

<img src="./figures/forecast_maxhorizon_7_us_gwinnett_ga_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_gwinnett_ga.png" width="425"/>
<em>us - gwinnett_ga</em>

<img src="./figures/forecast_maxhorizon_7_us_dekalb_ga_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_dekalb_ga.png" width="425"/>
<em>us - dekalb_ga</em>

<img src="./figures/forecast_maxhorizon_7_us_floyd_ga_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_floyd_ga.png" width="425"/>
<em>us - floyd_ga</em>

<img src="./figures/forecast_maxhorizon_7_us_fayette_ga_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_fayette_ga.png" width="425"/>
<em>us - fayette_ga</em>

<img src="./figures/forecast_maxhorizon_7_us_gregg_tx_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_gregg_tx.png" width="425"/>
<em>us - gregg_tx</em>

<img src="./figures/forecast_maxhorizon_7_us_monmouth_nj_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_monmouth_nj.png" width="425"/>
<em>us - monmouth_nj</em>

<img src="./figures/forecast_maxhorizon_7_us_burlington_nj_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_burlington_nj.png" width="425"/>
<em>us - burlington_nj</em>

<img src="./figures/forecast_maxhorizon_7_us_camden_nj_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_camden_nj.png" width="425"/>
<em>us - camden_nj</em>

<img src="./figures/forecast_maxhorizon_7_us_passaic_nj_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_passaic_nj.png" width="425"/>
<em>us - passaic_nj</em>

<img src="./figures/forecast_maxhorizon_7_us_union_nj_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_union_nj.png" width="425"/>
<em>us - union_nj</em>

<img src="./figures/forecast_maxhorizon_7_us_eagle_co_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_eagle_co.png" width="425"/>
<em>us - eagle_co</em>

<img src="./figures/forecast_maxhorizon_7_us_larimer_co_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_larimer_co.png" width="425"/>
<em>us - larimer_co</em>

<img src="./figures/forecast_maxhorizon_7_us_arapahoe_co_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_arapahoe_co.png" width="425"/>
<em>us - arapahoe_co</em>

<img src="./figures/forecast_maxhorizon_7_us_gunnison_co_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_gunnison_co.png" width="425"/>
<em>us - gunnison_co</em>

<img src="./figures/forecast_maxhorizon_7_us_kane_il_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_kane_il.png" width="425"/>
<em>us - kane_il</em>

<img src="./figures/forecast_maxhorizon_7_us_monroe_pa_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_monroe_pa.png" width="425"/>
<em>us - monroe_pa</em>

<img src="./figures/forecast_maxhorizon_7_us_philadelphia_pa_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_philadelphia_pa.png" width="425"/>
<em>us - philadelphia_pa</em>

<img src="./figures/forecast_maxhorizon_7_us_norfolk_va_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_norfolk_va.png" width="425"/>
<em>us - norfolk_va</em>

<img src="./figures/forecast_maxhorizon_7_us_arlington_va_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_arlington_va.png" width="425"/>
<em>us - arlington_va</em>

<img src="./figures/forecast_maxhorizon_7_us_spotsylvania_va_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_spotsylvania_va.png" width="425"/>
<em>us - spotsylvania_va</em>

<img src="./figures/forecast_maxhorizon_7_us_loudoun_va_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_loudoun_va.png" width="425"/>
<em>us - loudoun_va</em>

<img src="./figures/forecast_maxhorizon_7_us_prince_george's_md_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_prince_george's_md.png" width="425"/>
<em>us - prince_george's_md</em>

<img src="./figures/forecast_maxhorizon_7_us_pottawattamie_ia_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_pottawattamie_ia.png" width="425"/>
<em>us - pottawattamie_ia</em>

<img src="./figures/forecast_maxhorizon_7_us_camden_nc_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_camden_nc.png" width="425"/>
<em>us - camden_nc</em>

<img src="./figures/forecast_maxhorizon_7_us_pima_az_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_pima_az.png" width="425"/>
<em>us - pima_az</em>

<img src="./figures/forecast_maxhorizon_7_us_noble_in_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_noble_in.png" width="425"/>
<em>us - noble_in</em>

<img src="./figures/forecast_maxhorizon_7_us_adams_in_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_adams_in.png" width="425"/>
<em>us - adams_in</em>

<img src="./figures/forecast_maxhorizon_7_us_boone_in_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_boone_in.png" width="425"/>
<em>us - boone_in</em>

<img src="./figures/forecast_maxhorizon_7_us_dane_wi_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_dane_wi.png" width="425"/>
<em>us - dane_wi</em>

<img src="./figures/forecast_maxhorizon_7_us_pierce_wi_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_pierce_wi.png" width="425"/>
<em>us - pierce_wi</em>

<img src="./figures/forecast_maxhorizon_7_us_cuyahoga_oh_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_cuyahoga_oh.png" width="425"/>
<em>us - cuyahoga_oh</em>

<img src="./figures/forecast_maxhorizon_7_us_weber_ut_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_weber_ut.png" width="425"/>
<em>us - weber_ut</em>

<img src="./figures/forecast_maxhorizon_7_us_bennington_county_vt_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_bennington_county_vt.png" width="425"/>
<em>us - bennington_county_vt</em>

<img src="./figures/forecast_maxhorizon_7_us_carver_county_mn_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_carver_county_mn.png" width="425"/>
<em>us - carver_county_mn</em>

<img src="./figures/forecast_maxhorizon_7_us_charlotte_county_fl_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_charlotte_county_fl.png" width="425"/>
<em>us - charlotte_county_fl</em>

<img src="./figures/forecast_maxhorizon_7_us_cherokee_county_ga_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_cherokee_county_ga.png" width="425"/>
<em>us - cherokee_county_ga</em>

<img src="./figures/forecast_maxhorizon_7_us_collin_county_tx_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_collin_county_tx.png" width="425"/>
<em>us - collin_county_tx</em>

<img src="./figures/forecast_maxhorizon_7_us_jefferson_county_ky_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_jefferson_county_ky.png" width="425"/>
<em>us - jefferson_county_ky</em>

<img src="./figures/forecast_maxhorizon_7_us_jefferson_parish_la_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_jefferson_parish_la.png" width="425"/>
<em>us - jefferson_parish_la</em>

<img src="./figures/forecast_maxhorizon_7_us_shasta_county_ca_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_shasta_county_ca.png" width="425"/>
<em>us - shasta_county_ca</em>

<img src="./figures/forecast_maxhorizon_7_us_spartanburg_county_sc_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_spartanburg_county_sc.png" width="425"/>
<em>us - spartanburg_county_sc</em>

<img src="./figures/forecast_maxhorizon_7_us_harrison_county_ky_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_harrison_county_ky.png" width="425"/>
<em>us - harrison_county_ky</em>

<img src="./figures/forecast_maxhorizon_7_us_johnson_county_ia_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_johnson_county_ia.png" width="425"/>
<em>us - johnson_county_ia</em>

<img src="./figures/forecast_maxhorizon_7_us_berkshire_county_ma_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_berkshire_county_ma.png" width="425"/>
<em>us - berkshire_county_ma</em>

<img src="./figures/forecast_maxhorizon_7_us_davidson_county_tn_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_davidson_county_tn.png" width="425"/>
<em>us - davidson_county_tn</em>

<img src="./figures/forecast_maxhorizon_7_us_douglas_county_or_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_douglas_county_or.png" width="425"/>
<em>us - douglas_county_or</em>

<img src="./figures/forecast_maxhorizon_7_us_fresno_county_ca_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_fresno_county_ca.png" width="425"/>
<em>us - fresno_county_ca</em>

<img src="./figures/forecast_maxhorizon_7_us_harford_county_md_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_harford_county_md.png" width="425"/>
<em>us - harford_county_md</em>

<img src="./figures/forecast_maxhorizon_7_us_hendricks_county_in_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_hendricks_county_in.png" width="425"/>
<em>us - hendricks_county_in</em>

<img src="./figures/forecast_maxhorizon_7_us_hudson_county_nj_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_hudson_county_nj.png" width="425"/>
<em>us - hudson_county_nj</em>

<img src="./figures/forecast_maxhorizon_7_us_johnson_county_ks_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_johnson_county_ks.png" width="425"/>
<em>us - johnson_county_ks</em>

<img src="./figures/forecast_maxhorizon_7_us_kittitas_county_wa_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_kittitas_county_wa.png" width="425"/>
<em>us - kittitas_county_wa</em>

<img src="./figures/forecast_maxhorizon_7_us_manatee_county_fl_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_manatee_county_fl.png" width="425"/>
<em>us - manatee_county_fl</em>

<img src="./figures/forecast_maxhorizon_7_us_marion_county_or_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_marion_county_or.png" width="425"/>
<em>us - marion_county_or</em>

<img src="./figures/forecast_maxhorizon_7_us_okaloosa_county_fl_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_okaloosa_county_fl.png" width="425"/>
<em>us - okaloosa_county_fl</em>

<img src="./figures/forecast_maxhorizon_7_us_polk_county_ga_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_polk_county_ga.png" width="425"/>
<em>us - polk_county_ga</em>

<img src="./figures/forecast_maxhorizon_7_us_riverside_county_ca_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_riverside_county_ca.png" width="425"/>
<em>us - riverside_county_ca</em>

<img src="./figures/forecast_maxhorizon_7_us_shelby_county_tn_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_shelby_county_tn.png" width="425"/>
<em>us - shelby_county_tn</em>

<img src="./figures/forecast_maxhorizon_7_us_st._louis_county_mo_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_st._louis_county_mo.png" width="425"/>
<em>us - st._louis_county_mo</em>

<img src="./figures/forecast_maxhorizon_7_us_suffolk_county_ny_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_suffolk_county_ny.png" width="425"/>
<em>us - suffolk_county_ny</em>

<img src="./figures/forecast_maxhorizon_7_us_ulster_county_ny_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_ulster_county_ny.png" width="425"/>
<em>us - ulster_county_ny</em>

<img src="./figures/forecast_maxhorizon_7_us_volusia_county_fl_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_volusia_county_fl.png" width="425"/>
<em>us - volusia_county_fl</em>

<img src="./figures/forecast_maxhorizon_7_us_fairfax_county_va_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_fairfax_county_va.png" width="425"/>
<em>us - fairfax_county_va</em>

<img src="./figures/forecast_maxhorizon_7_us_rockingham_county_nh_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_rockingham_county_nh.png" width="425"/>
<em>us - rockingham_county_nh</em>

<img src="./figures/forecast_maxhorizon_7_us_washington_d.c._expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_washington_d.c..png" width="425"/>
<em>us - washington_d.c.</em>

<img src="./figures/forecast_maxhorizon_7_us_montgomery_county_pa_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_montgomery_county_pa.png" width="425"/>
<em>us - montgomery_county_pa</em>

<img src="./figures/forecast_maxhorizon_7_us_alameda_county_ca_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_alameda_county_ca.png" width="425"/>
<em>us - alameda_county_ca</em>

<img src="./figures/forecast_maxhorizon_7_us_broward_county_fl_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_broward_county_fl.png" width="425"/>
<em>us - broward_county_fl</em>

<img src="./figures/forecast_maxhorizon_7_us_lee_county_fl_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_lee_county_fl.png" width="425"/>
<em>us - lee_county_fl</em>

<img src="./figures/forecast_maxhorizon_7_us_pinal_county_az_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_pinal_county_az.png" width="425"/>
<em>us - pinal_county_az</em>

<img src="./figures/forecast_maxhorizon_7_us_rockland_county_ny_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_rockland_county_ny.png" width="425"/>
<em>us - rockland_county_ny</em>

<img src="./figures/forecast_maxhorizon_7_us_saratoga_county_ny_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_saratoga_county_ny.png" width="425"/>
<em>us - saratoga_county_ny</em>

<img src="./figures/forecast_maxhorizon_7_us_charleston_county_sc_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_charleston_county_sc.png" width="425"/>
<em>us - charleston_county_sc</em>

<img src="./figures/forecast_maxhorizon_7_us_clark_county_wa_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_clark_county_wa.png" width="425"/>
<em>us - clark_county_wa</em>

<img src="./figures/forecast_maxhorizon_7_us_cobb_county_ga_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_cobb_county_ga.png" width="425"/>
<em>us - cobb_county_ga</em>

<img src="./figures/forecast_maxhorizon_7_us_davis_county_ut_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_davis_county_ut.png" width="425"/>
<em>us - davis_county_ut</em>

<img src="./figures/forecast_maxhorizon_7_us_el_paso_county_co_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_el_paso_county_co.png" width="425"/>
<em>us - el_paso_county_co</em>

<img src="./figures/forecast_maxhorizon_7_us_honolulu_county_hi_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_honolulu_county_hi.png" width="425"/>
<em>us - honolulu_county_hi</em>

<img src="./figures/forecast_maxhorizon_7_us_jackson_county_or_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_jackson_county_or.png" width="425"/>
<em>us - jackson_county_or</em>

<img src="./figures/forecast_maxhorizon_7_us_jefferson_county_wa_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_jefferson_county_wa.png" width="425"/>
<em>us - jefferson_county_wa</em>

<img src="./figures/forecast_maxhorizon_7_us_kershaw_county_sc_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_kershaw_county_sc.png" width="425"/>
<em>us - kershaw_county_sc</em>

<img src="./figures/forecast_maxhorizon_7_us_klamath_county_or_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_klamath_county_or.png" width="425"/>
<em>us - klamath_county_or</em>

<img src="./figures/forecast_maxhorizon_7_us_madera_county_ca_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_madera_county_ca.png" width="425"/>
<em>us - madera_county_ca</em>

<img src="./figures/forecast_maxhorizon_7_us_pierce_county_wa_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_pierce_county_wa.png" width="425"/>
<em>us - pierce_county_wa</em>

<img src="./figures/forecast_maxhorizon_7_us_tulsa_county_ok_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_tulsa_county_ok.png" width="425"/>
<em>us - tulsa_county_ok</em>

<img src="./figures/forecast_maxhorizon_7_us_douglas_county_co_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_douglas_county_co.png" width="425"/>
<em>us - douglas_county_co</em>

<img src="./figures/forecast_maxhorizon_7_us_providence_county_ri_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_providence_county_ri.png" width="425"/>
<em>us - providence_county_ri</em>

<img src="./figures/forecast_maxhorizon_7_us_chatham_county_nc_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_chatham_county_nc.png" width="425"/>
<em>us - chatham_county_nc</em>

<img src="./figures/forecast_maxhorizon_7_us_delaware_county_pa_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_delaware_county_pa.png" width="425"/>
<em>us - delaware_county_pa</em>

<img src="./figures/forecast_maxhorizon_7_us_douglas_county_ne_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_douglas_county_ne.png" width="425"/>
<em>us - douglas_county_ne</em>

<img src="./figures/forecast_maxhorizon_7_us_fayette_county_ky_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_fayette_county_ky.png" width="425"/>
<em>us - fayette_county_ky</em>

<img src="./figures/forecast_maxhorizon_7_us_marion_county_in_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_marion_county_in.png" width="425"/>
<em>us - marion_county_in</em>

<img src="./figures/forecast_maxhorizon_7_us_middlesex_county_ma_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_middlesex_county_ma.png" width="425"/>
<em>us - middlesex_county_ma</em>

<img src="./figures/forecast_maxhorizon_7_us_nassau_county_ny_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_nassau_county_ny.png" width="425"/>
<em>us - nassau_county_ny</em>

<img src="./figures/forecast_maxhorizon_7_us_ramsey_county_mn_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_ramsey_county_mn.png" width="425"/>
<em>us - ramsey_county_mn</em>

<img src="./figures/forecast_maxhorizon_7_us_washoe_county_nv_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_washoe_county_nv.png" width="425"/>
<em>us - washoe_county_nv</em>

<img src="./figures/forecast_maxhorizon_7_us_wayne_county_pa_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_wayne_county_pa.png" width="425"/>
<em>us - wayne_county_pa</em>

<img src="./figures/forecast_maxhorizon_7_us_yolo_county_ca_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_yolo_county_ca.png" width="425"/>
<em>us - yolo_county_ca</em>

<img src="./figures/forecast_maxhorizon_7_us_santa_clara_county_ca_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_santa_clara_county_ca.png" width="425"/>
<em>us - santa_clara_county_ca</em>

<img src="./figures/forecast_maxhorizon_7_us_clark_county_nv_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_clark_county_nv.png" width="425"/>
<em>us - clark_county_nv</em>

<img src="./figures/forecast_maxhorizon_7_us_fort_bend_county_tx_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_fort_bend_county_tx.png" width="425"/>
<em>us - fort_bend_county_tx</em>

<img src="./figures/forecast_maxhorizon_7_us_grant_county_wa_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_grant_county_wa.png" width="425"/>
<em>us - grant_county_wa</em>

<img src="./figures/forecast_maxhorizon_7_us_santa_rosa_county_fl_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_santa_rosa_county_fl.png" width="425"/>
<em>us - santa_rosa_county_fl</em>

<img src="./figures/forecast_maxhorizon_7_us_williamson_county_tn_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_williamson_county_tn.png" width="425"/>
<em>us - williamson_county_tn</em>

<img src="./figures/forecast_maxhorizon_7_us_new_york_county_ny_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_new_york_county_ny.png" width="425"/>
<em>us - new_york_county_ny</em>

<img src="./figures/forecast_maxhorizon_7_us_montgomery_county_md_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_montgomery_county_md.png" width="425"/>
<em>us - montgomery_county_md</em>

<img src="./figures/forecast_maxhorizon_7_us_suffolk_county_ma_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_suffolk_county_ma.png" width="425"/>
<em>us - suffolk_county_ma</em>

<img src="./figures/forecast_maxhorizon_7_us_denver_county_co_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_denver_county_co.png" width="425"/>
<em>us - denver_county_co</em>

<img src="./figures/forecast_maxhorizon_7_us_summit_county_co_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_summit_county_co.png" width="425"/>
<em>us - summit_county_co</em>

<img src="./figures/forecast_maxhorizon_7_us_bergen_county_nj_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_bergen_county_nj.png" width="425"/>
<em>us - bergen_county_nj</em>

<img src="./figures/forecast_maxhorizon_7_us_harris_county_tx_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_harris_county_tx.png" width="425"/>
<em>us - harris_county_tx</em>

<img src="./figures/forecast_maxhorizon_7_us_san_francisco_county_ca_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_san_francisco_county_ca.png" width="425"/>
<em>us - san_francisco_county_ca</em>

<img src="./figures/forecast_maxhorizon_7_us_contra_costa_county_ca_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_contra_costa_county_ca.png" width="425"/>
<em>us - contra_costa_county_ca</em>

<img src="./figures/forecast_maxhorizon_7_us_orange_county_ca_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_orange_county_ca.png" width="425"/>
<em>us - orange_county_ca</em>

<img src="./figures/forecast_maxhorizon_7_us_norfolk_county_ma_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_norfolk_county_ma.png" width="425"/>
<em>us - norfolk_county_ma</em>

<img src="./figures/forecast_maxhorizon_7_us_maricopa_county_az_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_maricopa_county_az.png" width="425"/>
<em>us - maricopa_county_az</em>

<img src="./figures/forecast_maxhorizon_7_us_wake_county_nc_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_wake_county_nc.png" width="425"/>
<em>us - wake_county_nc</em>

<img src="./figures/forecast_maxhorizon_7_us_westchester_county_ny_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_westchester_county_ny.png" width="425"/>
<em>us - westchester_county_ny</em>

<img src="./figures/forecast_maxhorizon_7_us_grafton_county_nh_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_grafton_county_nh.png" width="425"/>
<em>us - grafton_county_nh</em>

<img src="./figures/forecast_maxhorizon_7_us_hillsborough_fl_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_hillsborough_fl.png" width="425"/>
<em>us - hillsborough_fl</em>

<img src="./figures/forecast_maxhorizon_7_us_placer_county_ca_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_placer_county_ca.png" width="425"/>
<em>us - placer_county_ca</em>

<img src="./figures/forecast_maxhorizon_7_us_san_mateo_ca_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_san_mateo_ca.png" width="425"/>
<em>us - san_mateo_ca</em>

<img src="./figures/forecast_maxhorizon_7_us_sonoma_county_ca_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_sonoma_county_ca.png" width="425"/>
<em>us - sonoma_county_ca</em>

<img src="./figures/forecast_maxhorizon_7_us_umatilla_or_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_umatilla_or.png" width="425"/>
<em>us - umatilla_or</em>

<img src="./figures/forecast_maxhorizon_7_us_fulton_county_ga_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_fulton_county_ga.png" width="425"/>
<em>us - fulton_county_ga</em>

<img src="./figures/forecast_maxhorizon_7_us_washington_county_or_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_washington_county_or.png" width="425"/>
<em>us - washington_county_or</em>

<img src="./figures/forecast_maxhorizon_7_us_snohomish_county_wa_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_snohomish_county_wa.png" width="425"/>
<em>us - snohomish_county_wa</em>

<img src="./figures/forecast_maxhorizon_7_us_humboldt_county_ca_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_humboldt_county_ca.png" width="425"/>
<em>us - humboldt_county_ca</em>

<img src="./figures/forecast_maxhorizon_7_us_sacramento_county_ca_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_sacramento_county_ca.png" width="425"/>
<em>us - sacramento_county_ca</em>

<img src="./figures/forecast_maxhorizon_7_us_san_diego_county_ca_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_san_diego_county_ca.png" width="425"/>
<em>us - san_diego_county_ca</em>

<img src="./figures/forecast_maxhorizon_7_us_san_benito_ca_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_san_benito_ca.png" width="425"/>
<em>us - san_benito_ca</em>

<img src="./figures/forecast_maxhorizon_7_us_los_angeles_ca_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_los_angeles_ca.png" width="425"/>
<em>us - los_angeles_ca</em>

<img src="./figures/forecast_maxhorizon_7_us_king_county_wa_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_king_county_wa.png" width="425"/>
<em>us - king_county_wa</em>

<img src="./figures/forecast_maxhorizon_7_us_cook_county_il_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_cook_county_il.png" width="425"/>
<em>us - cook_county_il</em>

<img src="./figures/forecast_maxhorizon_7_us_skagit_wa_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_skagit_wa.png" width="425"/>
<em>us - skagit_wa</em>

<img src="./figures/forecast_maxhorizon_7_us_thurston_wa_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_thurston_wa.png" width="425"/>
<em>us - thurston_wa</em>

<img src="./figures/forecast_maxhorizon_7_us_island_wa_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_island_wa.png" width="425"/>
<em>us - island_wa</em>

<img src="./figures/forecast_maxhorizon_7_us_whatcom_wa_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_whatcom_wa.png" width="425"/>
<em>us - whatcom_wa</em>

<img src="./figures/forecast_maxhorizon_7_us_marin_ca_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_marin_ca.png" width="425"/>
<em>us - marin_ca</em>

<img src="./figures/forecast_maxhorizon_7_us_calaveras_ca_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_calaveras_ca.png" width="425"/>
<em>us - calaveras_ca</em>

<img src="./figures/forecast_maxhorizon_7_us_stanislaus_ca_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_stanislaus_ca.png" width="425"/>
<em>us - stanislaus_ca</em>

<img src="./figures/forecast_maxhorizon_7_us_san_joaquin_ca_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_san_joaquin_ca.png" width="425"/>
<em>us - san_joaquin_ca</em>

<img src="./figures/forecast_maxhorizon_7_us_essex_ma_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_essex_ma.png" width="425"/>
<em>us - essex_ma</em>

<img src="./figures/forecast_maxhorizon_7_us_charlton_ga_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_charlton_ga.png" width="425"/>
<em>us - charlton_ga</em>

<img src="./figures/forecast_maxhorizon_7_us_collier_fl_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_collier_fl.png" width="425"/>
<em>us - collier_fl</em>

<img src="./figures/forecast_maxhorizon_7_us_pinellas_fl_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_pinellas_fl.png" width="425"/>
<em>us - pinellas_fl</em>

<img src="./figures/forecast_maxhorizon_7_us_alachua_fl_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_alachua_fl.png" width="425"/>
<em>us - alachua_fl</em>

<img src="./figures/forecast_maxhorizon_7_us_nassau_fl_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_nassau_fl.png" width="425"/>
<em>us - nassau_fl</em>

<img src="./figures/forecast_maxhorizon_7_us_pasco_fl_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_pasco_fl.png" width="425"/>
<em>us - pasco_fl</em>

<img src="./figures/forecast_maxhorizon_7_us_dallas_tx_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_dallas_tx.png" width="425"/>
<em>us - dallas_tx</em>

<img src="./figures/forecast_maxhorizon_7_us_tarrant_tx_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_tarrant_tx.png" width="425"/>
<em>us - tarrant_tx</em>

<img src="./figures/forecast_maxhorizon_7_us_montgomery_tx_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_montgomery_tx.png" width="425"/>
<em>us - montgomery_tx</em>

<img src="./figures/forecast_maxhorizon_7_us_middlesex_nj_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_middlesex_nj.png" width="425"/>
<em>us - middlesex_nj</em>

<img src="./figures/forecast_maxhorizon_7_us_jefferson_co_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_jefferson_co.png" width="425"/>
<em>us - jefferson_co</em>

<img src="./figures/forecast_maxhorizon_7_us_multnomah_or_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_multnomah_or.png" width="425"/>
<em>us - multnomah_or</em>

<img src="./figures/forecast_maxhorizon_7_us_polk_or_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_polk_or.png" width="425"/>
<em>us - polk_or</em>

<img src="./figures/forecast_maxhorizon_7_us_deschutes_or_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_deschutes_or.png" width="425"/>
<em>us - deschutes_or</em>

<img src="./figures/forecast_maxhorizon_7_us_mchenry_il_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_mchenry_il.png" width="425"/>
<em>us - mchenry_il</em>

<img src="./figures/forecast_maxhorizon_7_us_lake_il_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_lake_il.png" width="425"/>
<em>us - lake_il</em>

<img src="./figures/forecast_maxhorizon_7_us_bucks_pa_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_bucks_pa.png" width="425"/>
<em>us - bucks_pa</em>

<img src="./figures/forecast_maxhorizon_7_us_hanover_va_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_hanover_va.png" width="425"/>
<em>us - hanover_va</em>

<img src="./figures/forecast_maxhorizon_7_us_lancaster_sc_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_lancaster_sc.png" width="425"/>
<em>us - lancaster_sc</em>

<img src="./figures/forecast_maxhorizon_7_us_sullivan_tn_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_sullivan_tn.png" width="425"/>
<em>us - sullivan_tn</em>

<img src="./figures/forecast_maxhorizon_7_us_johnson_in_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_johnson_in.png" width="425"/>
<em>us - johnson_in</em>

<img src="./figures/forecast_maxhorizon_7_us_howard_in_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_howard_in.png" width="425"/>
<em>us - howard_in</em>

<img src="./figures/forecast_maxhorizon_7_us_st._joseph_in_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_st._joseph_in.png" width="425"/>
<em>us - st._joseph_in</em>

<img src="./figures/forecast_maxhorizon_7_us_knox_ne_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_knox_ne.png" width="425"/>
<em>us - knox_ne</em>

<img src="./figures/forecast_maxhorizon_7_us_stark_oh_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_stark_oh.png" width="425"/>
<em>us - stark_oh</em>

<img src="./figures/forecast_maxhorizon_7_us_anoka_mn_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_anoka_mn.png" width="425"/>
<em>us - anoka_mn</em>

<img src="./figures/forecast_maxhorizon_7_us_olmsted_mn_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_olmsted_mn.png" width="425"/>
<em>us - olmsted_mn</em>

<img src="./figures/forecast_maxhorizon_7_us_summit_ut_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_summit_ut.png" width="425"/>
<em>us - summit_ut</em>

<img src="./figures/forecast_maxhorizon_7_us_fairfield_ct_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_fairfield_ct.png" width="425"/>
<em>us - fairfield_ct</em>

<img src="./figures/forecast_maxhorizon_7_us_litchfield_ct_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_litchfield_ct.png" width="425"/>
<em>us - litchfield_ct</em>

<img src="./figures/forecast_maxhorizon_7_us_orleans_la_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_orleans_la.png" width="425"/>
<em>us - orleans_la</em>

<img src="./figures/forecast_maxhorizon_7_us_pennington_sd_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_pennington_sd.png" width="425"/>
<em>us - pennington_sd</em>

<img src="./figures/forecast_maxhorizon_7_us_beadle_sd_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_beadle_sd.png" width="425"/>
<em>us - beadle_sd</em>

<img src="./figures/forecast_maxhorizon_7_us_charles_mix_sd_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_charles_mix_sd.png" width="425"/>
<em>us - charles_mix_sd</em>

<img src="./figures/forecast_maxhorizon_7_us_davison_sd_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_davison_sd.png" width="425"/>
<em>us - davison_sd</em>

<img src="./figures/forecast_maxhorizon_7_us_minnehaha_sd_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_minnehaha_sd.png" width="425"/>
<em>us - minnehaha_sd</em>

<img src="./figures/forecast_maxhorizon_7_us_bon_homme_sd_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_bon_homme_sd.png" width="425"/>
<em>us - bon_homme_sd</em>

<img src="./figures/forecast_maxhorizon_7_us_socorro_nm_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_socorro_nm.png" width="425"/>
<em>us - socorro_nm</em>

<img src="./figures/forecast_maxhorizon_7_us_bernalillo_nm_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_bernalillo_nm.png" width="425"/>
<em>us - bernalillo_nm</em>

<img src="./figures/forecast_maxhorizon_7_us_oakland_mi_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_oakland_mi.png" width="425"/>
<em>us - oakland_mi</em>

<img src="./figures/forecast_maxhorizon_7_us_wayne_mi_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_wayne_mi.png" width="425"/>
<em>us - wayne_mi</em>

<img src="./figures/forecast_maxhorizon_7_us_new_castle_de_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_new_castle_de.png" width="425"/>
<em>us - new_castle_de</em>

<img src="./figures/forecast_maxhorizon_7_cuba__expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_cuba_.png" width="425"/>
<em>cuba - </em>

<img src="./figures/forecast_maxhorizon_7_guyana__expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_guyana_.png" width="425"/>
<em>guyana - </em>

<img src="./figures/forecast_maxhorizon_7_australia_australian_capital_territory_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_australia_australian_capital_territory.png" width="425"/>
<em>australia - australian_capital_territory</em>

<img src="./figures/forecast_maxhorizon_7_united_kingdom_united_kingdom_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_united_kingdom_united_kingdom.png" width="425"/>
<em>united_kingdom - united_kingdom</em>

<img src="./figures/forecast_maxhorizon_7_kazakhstan__expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_kazakhstan_.png" width="425"/>
<em>kazakhstan - </em>

<img src="./figures/forecast_maxhorizon_7_france_french_polynesia_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_france_french_polynesia.png" width="425"/>
<em>france - french_polynesia</em>

<img src="./figures/forecast_maxhorizon_7_cayman_islands__expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_cayman_islands_.png" width="425"/>
<em>cayman_islands - </em>

<img src="./figures/forecast_maxhorizon_7_guadeloupe__expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_guadeloupe_.png" width="425"/>
<em>guadeloupe - </em>

<img src="./figures/forecast_maxhorizon_7_canada_manitoba_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_canada_manitoba.png" width="425"/>
<em>canada - manitoba</em>

<img src="./figures/forecast_maxhorizon_7_canada_saskatchewan_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_canada_saskatchewan.png" width="425"/>
<em>canada - saskatchewan</em>

<img src="./figures/forecast_maxhorizon_7_ethiopia__expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_ethiopia_.png" width="425"/>
<em>ethiopia - </em>

<img src="./figures/forecast_maxhorizon_7_sudan__expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_sudan_.png" width="425"/>
<em>sudan - </em>

<img src="./figures/forecast_maxhorizon_7_guinea__expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_guinea_.png" width="425"/>
<em>guinea - </em>

<img src="./figures/forecast_maxhorizon_7_aruba__expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_aruba_.png" width="425"/>
<em>aruba - </em>

<img src="./figures/forecast_maxhorizon_7_canada_grand_princess_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_canada_grand_princess.png" width="425"/>
<em>canada - grand_princess</em>

<img src="./figures/forecast_maxhorizon_7_kenya__expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_kenya_.png" width="425"/>
<em>kenya - </em>

<img src="./figures/forecast_maxhorizon_7_antigua_and_barbuda__expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_antigua_and_barbuda_.png" width="425"/>
<em>antigua_and_barbuda - </em>

<img src="./figures/forecast_maxhorizon_7_us_alabama_expost.png" width="425"/> <img src="./figures/forecast_maxhorizon_7_us_alabama.png" width="425"/>
<em>us - alabama</em>


