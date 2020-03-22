# Time-series based 7-days ahead forecasts of (known) confirmed cases of the novel Corona virus COVID-19 (2019-nCoV)

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

The middle panel shows forecasts made on latest data for the forthcoming 7 days. The left panel depicts both the historic and predicted day-to-day changes of confirmed cases.

<img src="./figures/forecast_maxhorizon_7_thailand__expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_thailand_.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_thailand__first_difference.png" width="260"/>
<em>thailand - </em>

<img src="./figures/forecast_maxhorizon_7_japan__expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_japan_.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_japan__first_difference.png" width="260"/>
<em>japan - </em>

<img src="./figures/forecast_maxhorizon_7_singapore__expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_singapore_.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_singapore__first_difference.png" width="260"/>
<em>singapore - </em>

<img src="./figures/forecast_maxhorizon_7_malaysia__expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_malaysia_.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_malaysia__first_difference.png" width="260"/>
<em>malaysia - </em>

<img src="./figures/forecast_maxhorizon_7_canada_british_columbia_expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_canada_british_columbia.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_canada_british_columbia_first_difference.png" width="260"/>
<em>canada - british_columbia</em>

<img src="./figures/forecast_maxhorizon_7_australia_new_south_wales_expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_australia_new_south_wales.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_australia_new_south_wales_first_difference.png" width="260"/>
<em>australia - new_south_wales</em>

<img src="./figures/forecast_maxhorizon_7_australia_victoria_expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_australia_victoria.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_australia_victoria_first_difference.png" width="260"/>
<em>australia - victoria</em>

<img src="./figures/forecast_maxhorizon_7_australia_queensland_expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_australia_queensland.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_australia_queensland_first_difference.png" width="260"/>
<em>australia - queensland</em>

<img src="./figures/forecast_maxhorizon_7_cambodia__expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_cambodia_.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_cambodia__first_difference.png" width="260"/>
<em>cambodia - </em>

<img src="./figures/forecast_maxhorizon_7_sri_lanka__expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_sri_lanka_.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_sri_lanka__first_difference.png" width="260"/>
<em>sri_lanka - </em>

<img src="./figures/forecast_maxhorizon_7_germany__expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_germany_.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_germany__first_difference.png" width="260"/>
<em>germany - </em>

<img src="./figures/forecast_maxhorizon_7_finland__expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_finland_.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_finland__first_difference.png" width="260"/>
<em>finland - </em>

<img src="./figures/forecast_maxhorizon_7_united_arab_emirates__expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_united_arab_emirates_.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_united_arab_emirates__first_difference.png" width="260"/>
<em>united_arab_emirates - </em>

<img src="./figures/forecast_maxhorizon_7_philippines__expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_philippines_.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_philippines__first_difference.png" width="260"/>
<em>philippines - </em>

<img src="./figures/forecast_maxhorizon_7_india__expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_india_.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_india__first_difference.png" width="260"/>
<em>india - </em>

<img src="./figures/forecast_maxhorizon_7_italy__expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_italy_.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_italy__first_difference.png" width="260"/>
<em>italy - </em>

<img src="./figures/forecast_maxhorizon_7_sweden__expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_sweden_.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_sweden__first_difference.png" width="260"/>
<em>sweden - </em>

<img src="./figures/forecast_maxhorizon_7_spain__expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_spain_.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_spain__first_difference.png" width="260"/>
<em>spain - </em>

<img src="./figures/forecast_maxhorizon_7_australia_south_australia_expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_australia_south_australia.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_australia_south_australia_first_difference.png" width="260"/>
<em>australia - south_australia</em>

<img src="./figures/forecast_maxhorizon_7_belgium__expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_belgium_.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_belgium__first_difference.png" width="260"/>
<em>belgium - </em>

<img src="./figures/forecast_maxhorizon_7_egypt__expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_egypt_.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_egypt__first_difference.png" width="260"/>
<em>egypt - </em>

<img src="./figures/forecast_maxhorizon_7_lebanon__expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_lebanon_.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_lebanon__first_difference.png" width="260"/>
<em>lebanon - </em>

<img src="./figures/forecast_maxhorizon_7_iraq__expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_iraq_.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_iraq__first_difference.png" width="260"/>
<em>iraq - </em>

<img src="./figures/forecast_maxhorizon_7_oman__expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_oman_.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_oman__first_difference.png" width="260"/>
<em>oman - </em>

<img src="./figures/forecast_maxhorizon_7_bahrain__expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_bahrain_.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_bahrain__first_difference.png" width="260"/>
<em>bahrain - </em>

<img src="./figures/forecast_maxhorizon_7_kuwait__expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_kuwait_.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_kuwait__first_difference.png" width="260"/>
<em>kuwait - </em>

<img src="./figures/forecast_maxhorizon_7_algeria__expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_algeria_.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_algeria__first_difference.png" width="260"/>
<em>algeria - </em>

<img src="./figures/forecast_maxhorizon_7_croatia__expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_croatia_.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_croatia__first_difference.png" width="260"/>
<em>croatia - </em>

<img src="./figures/forecast_maxhorizon_7_switzerland__expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_switzerland_.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_switzerland__first_difference.png" width="260"/>
<em>switzerland - </em>

<img src="./figures/forecast_maxhorizon_7_austria__expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_austria_.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_austria__first_difference.png" width="260"/>
<em>austria - </em>

<img src="./figures/forecast_maxhorizon_7_israel__expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_israel_.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_israel__first_difference.png" width="260"/>
<em>israel - </em>

<img src="./figures/forecast_maxhorizon_7_pakistan__expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_pakistan_.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_pakistan__first_difference.png" width="260"/>
<em>pakistan - </em>

<img src="./figures/forecast_maxhorizon_7_brazil__expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_brazil_.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_brazil__first_difference.png" width="260"/>
<em>brazil - </em>

<img src="./figures/forecast_maxhorizon_7_georgia__expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_georgia_.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_georgia__first_difference.png" width="260"/>
<em>georgia - </em>

<img src="./figures/forecast_maxhorizon_7_greece__expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_greece_.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_greece__first_difference.png" width="260"/>
<em>greece - </em>

<img src="./figures/forecast_maxhorizon_7_north_macedonia__expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_north_macedonia_.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_north_macedonia__first_difference.png" width="260"/>
<em>north_macedonia - </em>

<img src="./figures/forecast_maxhorizon_7_norway__expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_norway_.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_norway__first_difference.png" width="260"/>
<em>norway - </em>

<img src="./figures/forecast_maxhorizon_7_romania__expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_romania_.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_romania__first_difference.png" width="260"/>
<em>romania - </em>

<img src="./figures/forecast_maxhorizon_7_estonia__expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_estonia_.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_estonia__first_difference.png" width="260"/>
<em>estonia - </em>

<img src="./figures/forecast_maxhorizon_7_san_marino__expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_san_marino_.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_san_marino__first_difference.png" width="260"/>
<em>san_marino - </em>

<img src="./figures/forecast_maxhorizon_7_belarus__expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_belarus_.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_belarus__first_difference.png" width="260"/>
<em>belarus - </em>

<img src="./figures/forecast_maxhorizon_7_iceland__expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_iceland_.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_iceland__first_difference.png" width="260"/>
<em>iceland - </em>

<img src="./figures/forecast_maxhorizon_7_lithuania__expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_lithuania_.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_lithuania__first_difference.png" width="260"/>
<em>lithuania - </em>

<img src="./figures/forecast_maxhorizon_7_mexico__expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_mexico_.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_mexico__first_difference.png" width="260"/>
<em>mexico - </em>

<img src="./figures/forecast_maxhorizon_7_new_zealand__expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_new_zealand_.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_new_zealand__first_difference.png" width="260"/>
<em>new_zealand - </em>

<img src="./figures/forecast_maxhorizon_7_australia_western_australia_expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_australia_western_australia.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_australia_western_australia_first_difference.png" width="260"/>
<em>australia - western_australia</em>

<img src="./figures/forecast_maxhorizon_7_ireland__expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_ireland_.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_ireland__first_difference.png" width="260"/>
<em>ireland - </em>

<img src="./figures/forecast_maxhorizon_7_luxembourg__expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_luxembourg_.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_luxembourg__first_difference.png" width="260"/>
<em>luxembourg - </em>

<img src="./figures/forecast_maxhorizon_7_qatar__expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_qatar_.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_qatar__first_difference.png" width="260"/>
<em>qatar - </em>

<img src="./figures/forecast_maxhorizon_7_ecuador__expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_ecuador_.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_ecuador__first_difference.png" width="260"/>
<em>ecuador - </em>

<img src="./figures/forecast_maxhorizon_7_azerbaijan__expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_azerbaijan_.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_azerbaijan__first_difference.png" width="260"/>
<em>azerbaijan - </em>

<img src="./figures/forecast_maxhorizon_7_armenia__expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_armenia_.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_armenia__first_difference.png" width="260"/>
<em>armenia - </em>

<img src="./figures/forecast_maxhorizon_7_dominican_republic__expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_dominican_republic_.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_dominican_republic__first_difference.png" width="260"/>
<em>dominican_republic - </em>

<img src="./figures/forecast_maxhorizon_7_indonesia__expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_indonesia_.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_indonesia__first_difference.png" width="260"/>
<em>indonesia - </em>

<img src="./figures/forecast_maxhorizon_7_portugal__expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_portugal_.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_portugal__first_difference.png" width="260"/>
<em>portugal - </em>

<img src="./figures/forecast_maxhorizon_7_andorra__expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_andorra_.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_andorra__first_difference.png" width="260"/>
<em>andorra - </em>

<img src="./figures/forecast_maxhorizon_7_latvia__expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_latvia_.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_latvia__first_difference.png" width="260"/>
<em>latvia - </em>

<img src="./figures/forecast_maxhorizon_7_morocco__expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_morocco_.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_morocco__first_difference.png" width="260"/>
<em>morocco - </em>

<img src="./figures/forecast_maxhorizon_7_saudi_arabia__expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_saudi_arabia_.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_saudi_arabia__first_difference.png" width="260"/>
<em>saudi_arabia - </em>

<img src="./figures/forecast_maxhorizon_7_senegal__expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_senegal_.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_senegal__first_difference.png" width="260"/>
<em>senegal - </em>

<img src="./figures/forecast_maxhorizon_7_argentina__expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_argentina_.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_argentina__first_difference.png" width="260"/>
<em>argentina - </em>

<img src="./figures/forecast_maxhorizon_7_chile__expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_chile_.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_chile__first_difference.png" width="260"/>
<em>chile - </em>

<img src="./figures/forecast_maxhorizon_7_jordan__expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_jordan_.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_jordan__first_difference.png" width="260"/>
<em>jordan - </em>

<img src="./figures/forecast_maxhorizon_7_ukraine__expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_ukraine_.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_ukraine__first_difference.png" width="260"/>
<em>ukraine - </em>

<img src="./figures/forecast_maxhorizon_7_hungary__expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_hungary_.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_hungary__first_difference.png" width="260"/>
<em>hungary - </em>

<img src="./figures/forecast_maxhorizon_7_liechtenstein__expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_liechtenstein_.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_liechtenstein__first_difference.png" width="260"/>
<em>liechtenstein - </em>

<img src="./figures/forecast_maxhorizon_7_poland__expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_poland_.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_poland__first_difference.png" width="260"/>
<em>poland - </em>

<img src="./figures/forecast_maxhorizon_7_tunisia__expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_tunisia_.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_tunisia__first_difference.png" width="260"/>
<em>tunisia - </em>

<img src="./figures/forecast_maxhorizon_7_bosnia_and_herzegovina__expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_bosnia_and_herzegovina_.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_bosnia_and_herzegovina__first_difference.png" width="260"/>
<em>bosnia_and_herzegovina - </em>

<img src="./figures/forecast_maxhorizon_7_slovenia__expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_slovenia_.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_slovenia__first_difference.png" width="260"/>
<em>slovenia - </em>

<img src="./figures/forecast_maxhorizon_7_south_africa__expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_south_africa_.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_south_africa__first_difference.png" width="260"/>
<em>south_africa - </em>

<img src="./figures/forecast_maxhorizon_7_colombia__expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_colombia_.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_colombia__first_difference.png" width="260"/>
<em>colombia - </em>

<img src="./figures/forecast_maxhorizon_7_costa_rica__expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_costa_rica_.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_costa_rica__first_difference.png" width="260"/>
<em>costa_rica - </em>

<img src="./figures/forecast_maxhorizon_7_peru__expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_peru_.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_peru__first_difference.png" width="260"/>
<em>peru - </em>

<img src="./figures/forecast_maxhorizon_7_serbia__expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_serbia_.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_serbia__first_difference.png" width="260"/>
<em>serbia - </em>

<img src="./figures/forecast_maxhorizon_7_slovakia__expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_slovakia_.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_slovakia__first_difference.png" width="260"/>
<em>slovakia - </em>

<img src="./figures/forecast_maxhorizon_7_malta__expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_malta_.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_malta__first_difference.png" width="260"/>
<em>malta - </em>

<img src="./figures/forecast_maxhorizon_7_martinique__expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_martinique_.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_martinique__first_difference.png" width="260"/>
<em>martinique - </em>

<img src="./figures/forecast_maxhorizon_7_bulgaria__expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_bulgaria_.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_bulgaria__first_difference.png" width="260"/>
<em>bulgaria - </em>

<img src="./figures/forecast_maxhorizon_7_canada_ontario_expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_canada_ontario.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_canada_ontario_first_difference.png" width="260"/>
<em>canada - ontario</em>

<img src="./figures/forecast_maxhorizon_7_canada_alberta_expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_canada_alberta.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_canada_alberta_first_difference.png" width="260"/>
<em>canada - alberta</em>

<img src="./figures/forecast_maxhorizon_7_canada_quebec_expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_canada_quebec.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_canada_quebec_first_difference.png" width="260"/>
<em>canada - quebec</em>

<img src="./figures/forecast_maxhorizon_7_albania__expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_albania_.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_albania__first_difference.png" width="260"/>
<em>albania - </em>

<img src="./figures/forecast_maxhorizon_7_cyprus__expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_cyprus_.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_cyprus__first_difference.png" width="260"/>
<em>cyprus - </em>

<img src="./figures/forecast_maxhorizon_7_brunei__expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_brunei_.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_brunei__first_difference.png" width="260"/>
<em>brunei - </em>

<img src="./figures/forecast_maxhorizon_7_us_washington_expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_us_washington.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_us_washington_first_difference.png" width="260"/>
<em>us - washington</em>

<img src="./figures/forecast_maxhorizon_7_us_new_york_expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_us_new_york.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_us_new_york_first_difference.png" width="260"/>
<em>us - new_york</em>

<img src="./figures/forecast_maxhorizon_7_us_california_expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_us_california.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_us_california_first_difference.png" width="260"/>
<em>us - california</em>

<img src="./figures/forecast_maxhorizon_7_us_massachusetts_expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_us_massachusetts.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_us_massachusetts_first_difference.png" width="260"/>
<em>us - massachusetts</em>

<img src="./figures/forecast_maxhorizon_7_us_diamond_princess_expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_us_diamond_princess.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_us_diamond_princess_first_difference.png" width="260"/>
<em>us - diamond_princess</em>

<img src="./figures/forecast_maxhorizon_7_us_georgia_expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_us_georgia.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_us_georgia_first_difference.png" width="260"/>
<em>us - georgia</em>

<img src="./figures/forecast_maxhorizon_7_us_colorado_expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_us_colorado.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_us_colorado_first_difference.png" width="260"/>
<em>us - colorado</em>

<img src="./figures/forecast_maxhorizon_7_us_florida_expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_us_florida.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_us_florida_first_difference.png" width="260"/>
<em>us - florida</em>

<img src="./figures/forecast_maxhorizon_7_us_new_jersey_expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_us_new_jersey.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_us_new_jersey_first_difference.png" width="260"/>
<em>us - new_jersey</em>

<img src="./figures/forecast_maxhorizon_7_us_oregon_expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_us_oregon.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_us_oregon_first_difference.png" width="260"/>
<em>us - oregon</em>

<img src="./figures/forecast_maxhorizon_7_us_texas_expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_us_texas.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_us_texas_first_difference.png" width="260"/>
<em>us - texas</em>

<img src="./figures/forecast_maxhorizon_7_us_illinois_expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_us_illinois.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_us_illinois_first_difference.png" width="260"/>
<em>us - illinois</em>

<img src="./figures/forecast_maxhorizon_7_us_pennsylvania_expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_us_pennsylvania.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_us_pennsylvania_first_difference.png" width="260"/>
<em>us - pennsylvania</em>

<img src="./figures/forecast_maxhorizon_7_us_iowa_expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_us_iowa.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_us_iowa_first_difference.png" width="260"/>
<em>us - iowa</em>

<img src="./figures/forecast_maxhorizon_7_us_maryland_expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_us_maryland.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_us_maryland_first_difference.png" width="260"/>
<em>us - maryland</em>

<img src="./figures/forecast_maxhorizon_7_us_north_carolina_expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_us_north_carolina.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_us_north_carolina_first_difference.png" width="260"/>
<em>us - north_carolina</em>

<img src="./figures/forecast_maxhorizon_7_us_south_carolina_expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_us_south_carolina.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_us_south_carolina_first_difference.png" width="260"/>
<em>us - south_carolina</em>

<img src="./figures/forecast_maxhorizon_7_us_tennessee_expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_us_tennessee.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_us_tennessee_first_difference.png" width="260"/>
<em>us - tennessee</em>

<img src="./figures/forecast_maxhorizon_7_us_virginia_expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_us_virginia.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_us_virginia_first_difference.png" width="260"/>
<em>us - virginia</em>

<img src="./figures/forecast_maxhorizon_7_us_arizona_expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_us_arizona.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_us_arizona_first_difference.png" width="260"/>
<em>us - arizona</em>

<img src="./figures/forecast_maxhorizon_7_us_indiana_expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_us_indiana.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_us_indiana_first_difference.png" width="260"/>
<em>us - indiana</em>

<img src="./figures/forecast_maxhorizon_7_us_kentucky_expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_us_kentucky.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_us_kentucky_first_difference.png" width="260"/>
<em>us - kentucky</em>

<img src="./figures/forecast_maxhorizon_7_us_district_of_columbia_expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_us_district_of_columbia.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_us_district_of_columbia_first_difference.png" width="260"/>
<em>us - district_of_columbia</em>

<img src="./figures/forecast_maxhorizon_7_us_nevada_expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_us_nevada.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_us_nevada_first_difference.png" width="260"/>
<em>us - nevada</em>

<img src="./figures/forecast_maxhorizon_7_us_new_hampshire_expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_us_new_hampshire.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_us_new_hampshire_first_difference.png" width="260"/>
<em>us - new_hampshire</em>

<img src="./figures/forecast_maxhorizon_7_us_minnesota_expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_us_minnesota.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_us_minnesota_first_difference.png" width="260"/>
<em>us - minnesota</em>

<img src="./figures/forecast_maxhorizon_7_us_nebraska_expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_us_nebraska.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_us_nebraska_first_difference.png" width="260"/>
<em>us - nebraska</em>

<img src="./figures/forecast_maxhorizon_7_us_ohio_expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_us_ohio.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_us_ohio_first_difference.png" width="260"/>
<em>us - ohio</em>

<img src="./figures/forecast_maxhorizon_7_us_rhode_island_expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_us_rhode_island.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_us_rhode_island_first_difference.png" width="260"/>
<em>us - rhode_island</em>

<img src="./figures/forecast_maxhorizon_7_us_wisconsin_expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_us_wisconsin.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_us_wisconsin_first_difference.png" width="260"/>
<em>us - wisconsin</em>

<img src="./figures/forecast_maxhorizon_7_us_connecticut_expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_us_connecticut.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_us_connecticut_first_difference.png" width="260"/>
<em>us - connecticut</em>

<img src="./figures/forecast_maxhorizon_7_us_hawaii_expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_us_hawaii.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_us_hawaii_first_difference.png" width="260"/>
<em>us - hawaii</em>

<img src="./figures/forecast_maxhorizon_7_us_oklahoma_expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_us_oklahoma.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_us_oklahoma_first_difference.png" width="260"/>
<em>us - oklahoma</em>

<img src="./figures/forecast_maxhorizon_7_us_utah_expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_us_utah.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_us_utah_first_difference.png" width="260"/>
<em>us - utah</em>

<img src="./figures/forecast_maxhorizon_7_burkina_faso__expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_burkina_faso_.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_burkina_faso__first_difference.png" width="260"/>
<em>burkina_faso - </em>

<img src="./figures/forecast_maxhorizon_7_panama__expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_panama_.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_panama__first_difference.png" width="260"/>
<em>panama - </em>

<img src="./figures/forecast_maxhorizon_7_us_kansas_expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_us_kansas.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_us_kansas_first_difference.png" width="260"/>
<em>us - kansas</em>

<img src="./figures/forecast_maxhorizon_7_us_louisiana_expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_us_louisiana.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_us_louisiana_first_difference.png" width="260"/>
<em>us - louisiana</em>

<img src="./figures/forecast_maxhorizon_7_us_missouri_expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_us_missouri.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_us_missouri_first_difference.png" width="260"/>
<em>us - missouri</em>

<img src="./figures/forecast_maxhorizon_7_us_arkansas_expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_us_arkansas.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_us_arkansas_first_difference.png" width="260"/>
<em>us - arkansas</em>

<img src="./figures/forecast_maxhorizon_7_us_delaware_expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_us_delaware.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_us_delaware_first_difference.png" width="260"/>
<em>us - delaware</em>

<img src="./figures/forecast_maxhorizon_7_us_idaho_expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_us_idaho.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_us_idaho_first_difference.png" width="260"/>
<em>us - idaho</em>

<img src="./figures/forecast_maxhorizon_7_us_maine_expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_us_maine.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_us_maine_first_difference.png" width="260"/>
<em>us - maine</em>

<img src="./figures/forecast_maxhorizon_7_us_michigan_expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_us_michigan.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_us_michigan_first_difference.png" width="260"/>
<em>us - michigan</em>

<img src="./figures/forecast_maxhorizon_7_us_mississippi_expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_us_mississippi.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_us_mississippi_first_difference.png" width="260"/>
<em>us - mississippi</em>

<img src="./figures/forecast_maxhorizon_7_us_new_mexico_expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_us_new_mexico.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_us_new_mexico_first_difference.png" width="260"/>
<em>us - new_mexico</em>

<img src="./figures/forecast_maxhorizon_7_china_hubei_expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_china_hubei.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_china_hubei_first_difference.png" width="260"/>
<em>china - hubei</em>

<img src="./figures/forecast_maxhorizon_7_iran__expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_iran_.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_iran__first_difference.png" width="260"/>
<em>iran - </em>

<img src="./figures/forecast_maxhorizon_7_korea_south__expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_korea_south_.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_korea_south__first_difference.png" width="260"/>
<em>korea_south - </em>

<img src="./figures/forecast_maxhorizon_7_france_france_expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_france_france.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_france_france_first_difference.png" width="260"/>
<em>france - france</em>

<img src="./figures/forecast_maxhorizon_7_china_guangdong_expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_china_guangdong.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_china_guangdong_first_difference.png" width="260"/>
<em>china - guangdong</em>

<img src="./figures/forecast_maxhorizon_7_china_henan_expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_china_henan.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_china_henan_first_difference.png" width="260"/>
<em>china - henan</em>

<img src="./figures/forecast_maxhorizon_7_china_zhejiang_expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_china_zhejiang.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_china_zhejiang_first_difference.png" width="260"/>
<em>china - zhejiang</em>

<img src="./figures/forecast_maxhorizon_7_china_hunan_expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_china_hunan.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_china_hunan_first_difference.png" width="260"/>
<em>china - hunan</em>

<img src="./figures/forecast_maxhorizon_7_china_anhui_expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_china_anhui.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_china_anhui_first_difference.png" width="260"/>
<em>china - anhui</em>

<img src="./figures/forecast_maxhorizon_7_china_jiangxi_expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_china_jiangxi.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_china_jiangxi_first_difference.png" width="260"/>
<em>china - jiangxi</em>

<img src="./figures/forecast_maxhorizon_7_china_shandong_expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_china_shandong.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_china_shandong_first_difference.png" width="260"/>
<em>china - shandong</em>

<img src="./figures/forecast_maxhorizon_7_cruise_ship_diamond_princess_expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_cruise_ship_diamond_princess.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_cruise_ship_diamond_princess_first_difference.png" width="260"/>
<em>cruise_ship - diamond_princess</em>

<img src="./figures/forecast_maxhorizon_7_china_jiangsu_expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_china_jiangsu.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_china_jiangsu_first_difference.png" width="260"/>
<em>china - jiangsu</em>

<img src="./figures/forecast_maxhorizon_7_china_chongqing_expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_china_chongqing.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_china_chongqing_first_difference.png" width="260"/>
<em>china - chongqing</em>

<img src="./figures/forecast_maxhorizon_7_china_sichuan_expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_china_sichuan.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_china_sichuan_first_difference.png" width="260"/>
<em>china - sichuan</em>

<img src="./figures/forecast_maxhorizon_7_china_heilongjiang_expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_china_heilongjiang.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_china_heilongjiang_first_difference.png" width="260"/>
<em>china - heilongjiang</em>

<img src="./figures/forecast_maxhorizon_7_denmark_denmark_expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_denmark_denmark.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_denmark_denmark_first_difference.png" width="260"/>
<em>denmark - denmark</em>

<img src="./figures/forecast_maxhorizon_7_china_beijing_expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_china_beijing.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_china_beijing_first_difference.png" width="260"/>
<em>china - beijing</em>

<img src="./figures/forecast_maxhorizon_7_china_shanghai_expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_china_shanghai.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_china_shanghai_first_difference.png" width="260"/>
<em>china - shanghai</em>

<img src="./figures/forecast_maxhorizon_7_china_hebei_expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_china_hebei.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_china_hebei_first_difference.png" width="260"/>
<em>china - hebei</em>

<img src="./figures/forecast_maxhorizon_7_china_fujian_expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_china_fujian.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_china_fujian_first_difference.png" width="260"/>
<em>china - fujian</em>

<img src="./figures/forecast_maxhorizon_7_china_guangxi_expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_china_guangxi.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_china_guangxi_first_difference.png" width="260"/>
<em>china - guangxi</em>

<img src="./figures/forecast_maxhorizon_7_china_shaanxi_expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_china_shaanxi.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_china_shaanxi_first_difference.png" width="260"/>
<em>china - shaanxi</em>

<img src="./figures/forecast_maxhorizon_7_china_yunnan_expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_china_yunnan.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_china_yunnan_first_difference.png" width="260"/>
<em>china - yunnan</em>

<img src="./figures/forecast_maxhorizon_7_china_hainan_expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_china_hainan.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_china_hainan_first_difference.png" width="260"/>
<em>china - hainan</em>

<img src="./figures/forecast_maxhorizon_7_china_guizhou_expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_china_guizhou.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_china_guizhou_first_difference.png" width="260"/>
<em>china - guizhou</em>

<img src="./figures/forecast_maxhorizon_7_china_tianjin_expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_china_tianjin.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_china_tianjin_first_difference.png" width="260"/>
<em>china - tianjin</em>

<img src="./figures/forecast_maxhorizon_7_china_shanxi_expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_china_shanxi.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_china_shanxi_first_difference.png" width="260"/>
<em>china - shanxi</em>

<img src="./figures/forecast_maxhorizon_7_china_gansu_expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_china_gansu.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_china_gansu_first_difference.png" width="260"/>
<em>china - gansu</em>

<img src="./figures/forecast_maxhorizon_7_china_hong_kong_expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_china_hong_kong.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_china_hong_kong_first_difference.png" width="260"/>
<em>china - hong_kong</em>

<img src="./figures/forecast_maxhorizon_7_china_liaoning_expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_china_liaoning.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_china_liaoning_first_difference.png" width="260"/>
<em>china - liaoning</em>

<img src="./figures/forecast_maxhorizon_7_china_jilin_expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_china_jilin.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_china_jilin_first_difference.png" width="260"/>
<em>china - jilin</em>

<img src="./figures/forecast_maxhorizon_7_czechia__expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_czechia_.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_czechia__first_difference.png" width="260"/>
<em>czechia - </em>

<img src="./figures/forecast_maxhorizon_7_china_xinjiang_expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_china_xinjiang.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_china_xinjiang_first_difference.png" width="260"/>
<em>china - xinjiang</em>

<img src="./figures/forecast_maxhorizon_7_china_inner_mongolia_expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_china_inner_mongolia.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_china_inner_mongolia_first_difference.png" width="260"/>
<em>china - inner_mongolia</em>

<img src="./figures/forecast_maxhorizon_7_china_ningxia_expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_china_ningxia.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_china_ningxia_first_difference.png" width="260"/>
<em>china - ningxia</em>

<img src="./figures/forecast_maxhorizon_7_taiwan*__expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_taiwan*_.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_taiwan*__first_difference.png" width="260"/>
<em>taiwan* - </em>

<img src="./figures/forecast_maxhorizon_7_vietnam__expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_vietnam_.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_vietnam__first_difference.png" width="260"/>
<em>vietnam - </em>

<img src="./figures/forecast_maxhorizon_7_russia__expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_russia_.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_russia__first_difference.png" width="260"/>
<em>russia - </em>

<img src="./figures/forecast_maxhorizon_7_moldova__expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_moldova_.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_moldova__first_difference.png" width="260"/>
<em>moldova - </em>

<img src="./figures/forecast_maxhorizon_7_denmark_faroe_islands_expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_denmark_faroe_islands.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_denmark_faroe_islands_first_difference.png" width="260"/>
<em>denmark - faroe_islands</em>

<img src="./figures/forecast_maxhorizon_7_united_kingdom_channel_islands_expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_united_kingdom_channel_islands.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_united_kingdom_channel_islands_first_difference.png" width="260"/>
<em>united_kingdom - channel_islands</em>

<img src="./figures/forecast_maxhorizon_7_turkey__expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_turkey_.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_turkey__first_difference.png" width="260"/>
<em>turkey - </em>

<img src="./figures/forecast_maxhorizon_7_united_kingdom_united_kingdom_expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_united_kingdom_united_kingdom.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_united_kingdom_united_kingdom_first_difference.png" width="260"/>
<em>united_kingdom - united_kingdom</em>

<img src="./figures/forecast_maxhorizon_7_kazakhstan__expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_kazakhstan_.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_kazakhstan__first_difference.png" width="260"/>
<em>kazakhstan - </em>

<img src="./figures/forecast_maxhorizon_7_us_alabama_expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_us_alabama.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_us_alabama_first_difference.png" width="260"/>
<em>us - alabama</em>

<img src="./figures/forecast_maxhorizon_7_uruguay__expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_uruguay_.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_uruguay__first_difference.png" width="260"/>
<em>uruguay - </em>

<img src="./figures/forecast_maxhorizon_7_trinidad_and_tobago__expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_trinidad_and_tobago_.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_trinidad_and_tobago__first_difference.png" width="260"/>
<em>trinidad_and_tobago - </em>

<img src="./figures/forecast_maxhorizon_7_venezuela__expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_venezuela_.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_venezuela__first_difference.png" width="260"/>
<em>venezuela - </em>

<img src="./figures/forecast_maxhorizon_7_uzbekistan__expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_uzbekistan_.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_uzbekistan__first_difference.png" width="260"/>
<em>uzbekistan - </em>

<img src="./figures/forecast_maxhorizon_7_netherlands_netherlands_expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_netherlands_netherlands.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_netherlands_netherlands_first_difference.png" width="260"/>
<em>netherlands - netherlands</em>

<img src="./figures/forecast_maxhorizon_7_france_guadeloupe_expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_france_guadeloupe.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_france_guadeloupe_first_difference.png" width="260"/>
<em>france - guadeloupe</em>

<img src="./figures/forecast_maxhorizon_7_france_reunion_expost.png" width="260"/>            <img src="./figures/forecast_maxhorizon_7_france_reunion.png" width="260"/> <img src="./figures/forecast_maxhorizon_7_france_reunion_first_difference.png" width="260"/>
<em>france - reunion</em>
