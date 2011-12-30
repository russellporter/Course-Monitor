#!/usr/bin/env ruby

require 'rubygems'
require 'ruby_gntp'
require 'mechanize'

class Growl
	@@gntp = GNTP.new("Course Monitor")
	@@gntp.register({:notifications => [{
		:name     => "course_monitor",
		:enabled  => true,
	}]})
	
	@@icons = {
		:yes => 'http://textbookrevolution.org/images/thumb/b/bd/Checkmark_green.svg/417px-Checkmark_green.svg.png',
		:no => 'http://textbookrevolution.org/images/thumb/e/e2/RedX.svg/500px-RedX.svg.png'
	}
			
	def self.notify(title, message, status = :yes, sticky = false)
		@@gntp.notify({
		  :name  => "course_monitor",
		  :title => title,
		  :text  => message,
		  :sticky=> sticky,
		  :icon => @@icons[status],
		})
	end
end

class CourseChecker 
	# For GERM100 Section 011, department = GERM, number = 100, section = 011
	def self.check(course)
		a = Mechanize.new
		a.get("https://courses.students.ubc.ca/cs/main?pname=subjarea&tname=subjareas&req=5&dept=#{course.department}&course=#{course.number}&section=#{course.section}") do |page|
			unless page.body.include? 'Note: this section is full' then
				# class isn't full
				Growl.notify "UBC Course Availability", "#{course.name} is currently available!", :yes
			else
				# class is full
				Growl.notify "UBC Course Availability", "#{course.name} is not available", :no
			end
		end
	end
end

class Course
	attr_accessor :department, :number, :section
	
	def initialize(name_or_options)
		if name_or_options.instance_of? Hash then
			options = name_or_options
			@department = options[:department]
			@number = options[:number]
			@section = options[:section]
		else
			@department = ""
			@number = ""
			@section = ""
			name = name_or_options
			
			stage = :department
			name.split("").each do |i|
				if(['-'].include? i) then
					stage = :section
				elsif(stage == :section) then
					@section << i
  			elsif(['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'].include? i or stage != :department) then
	  			stage = :number
	  			@number << i
	  		else
		  		@department << i
		  	end
			end
		end
	end
	
	def name
		return "#{@department}#{@number}-#{@section}"
	end
end

courses = ['GERM100-011']
courses.map! { |course|
	Course.new(course)
}

courses.each { |course|
	CourseChecker.check(course)
}
