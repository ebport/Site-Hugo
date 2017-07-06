+++
categories = ["tutorial"]
comments = false
date = "2017-06-02"
draft = false
showpagemeta = true
showcomments = true
slug = ""
tags = ["python", "fitbit", "api"]
title = "Build a Fitbit Heart Rate Extract"

+++

A Fitbit collects an incredible amount of granular data on personal activity, heart rate, and sleep. However, currently most of the detailed data is locked up within the app. This tutorial shows a simple way to extract the heart rate data in an automated fashion.

This code will generate 'personal data extracts' according to simple specifications, without requiring any copy pasting or manual effort beyond the initial configuration.

Many others have posted helpful tutorials on this topic. I've included a list at the end of this post. The one thing that frustrated me was that most other examples required manual copying of credentials each time. By running a minimal local web server with python we can eliminate this step and fully automate the process.

## Setup
This sections contains info on setting up your personal Fitbit app.

### Create a Fitbit App

* Go to the Fitbit [developer site](https://dev.fitbit.com/apps/) and log in.
* Select register a new app.
* Fill in the fields. The important values are application type and callback url.

![Register Application](/img/FitbitRegister.png)

* Once the app is registered, select it to view the details. We'll use these in a bit to configure our data extract.

### Python Setup
If you don't have Python installed, you'll need to install it. Any version >3.5 will work.

* Download and install Python https://www.python.org/downloads/
* Check installation from the terminal.

```
python --version
```
* Use pip to install the requests dependency from the terminal.

```
pip install requests
```

If you run into any issues, there are many Python/Pip tutorials out there. I recommend [this one](http://python-guide-pt-br.readthedocs.io/en/latest/starting/installation/).

### Github Code
The code for this project is available on [Github](https://github.com/ebport/Fitbit-HR).

If you already have git installed, clone the repository.

```
git clone https://github.com/ebport/Fitbit-HR
```

If you don't have git, you can download the zipped code from [Github](https://github.com/ebport/Fitbit-HR).

## Using the code
Now we are ready to put the code to use.

### Configuration
First we need to go back to the [Fitbit Site](https://dev.fitbit.com/apps) and get the configuration info for our app. Once you select your app you should your app details.

![App Details](/img/FitbitAppDetails.png)

Now we need to enter this info into the `keys.py` file. Note this file is named `keys_dummy.py`. You'll want to rename and edit. The `.gitignore` file will prevent the uploading of app keys to Github.

```
cp keys_dummy.py keys.py
```
Add your client_id and client_secret to `keys.py`.

```
client_id = <insert your client_id>
client_secret = <insert your client secret>
```

### Basic Usage
Now we are ready to go.

```
python fitbit.py
```

Login when the authentication window opens in your browser. Then grant the app permission to access your data.
<insert image>

Check the default output dir and you should see the files hr.json and hr.csv.
```
ls fitbit_data/
head hr.csv
```

### Customizing Data Output
By default the `fitbit.py` script pulls all data for today at 1 min intervals. However, you can get data for any day in 1min or 1sec intervals by modifying the configuration arguments.

Command line usage

```
python fitbit.py 2017-06-01 1min
```

Other possible modifications:

* Change output directories
* Add fields
* Add other extracts

### Additional Comments

* OAuth 2.0 was the key barrier to fully automating this.
* Python standard library `webrowser` and `http.server` modules were key.
* Configuration can be generalized in the future. The script already supports multiple extracts. Define a function to process each json file and create a new dict in the `fitbit_config.py` extract list.
* Refactoring would be beneficial, but for now this works to generate quick and dirty data extracts.
