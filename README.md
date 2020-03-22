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

The right panel shows forecasts made on latest data for the forthcoming 7 days.

<img src="./figures/forecast_maxhorizon_7_thailand__expost.png" width="225"/>            <img src="./figures/forecast_maxhorizon_7_thailand_.png" width="225"/> <img src="./figures/forecast_maxhorizon_7_thailand__first_difference.png" width="225"/>
<em>thailand - </em>

<img src="./figures/forecast_maxhorizon_7_japan__expost.png" width="225"/>            <img src="./figures/forecast_maxhorizon_7_japan_.png" width="225"/> <img src="./figures/forecast_maxhorizon_7_japan__first_difference.png" width="225"/>
<em>japan - </em>
