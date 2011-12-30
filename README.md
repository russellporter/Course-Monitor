## Setup

1. Install RVM
2. `bundle install`
3. Add your classes to monitor in monitor.rb
4. Add monitor.rb to your crontab at whatever interval you decide:

	SHELL=/bin/bash
	BASH_ENV=/Users/russell/.bash_profile
	
	* * * * * $HOME/Code/CourseMonitor/monitor.rb
	

## TODO

- Extract course list to another file