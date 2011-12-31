# Course Monitor

Simple Ruby script for monitoring availability of UBC courses. Often times you want to switch to a full section in the first week of classes. It might be full right then, but people are changing classes so often the class will have space for a few minutes. Now you know!

Notification when a class has space is provided through Growl (make sure you have that installed)! The notification will stick on your screen so you won't miss it if you are AFK.

## Setup

1. Clone the git repo to ~/Code/CourseMonitor
2. Install RVM and Growl
3. `bundle install`
4. Add your classes to monitor in monitor.rb
5. Add Monitor.app to your Mac Login Items.

## TODO

- Extract course list to another file