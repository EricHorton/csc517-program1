# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Admin.create name: 'Default Admin', email: 'admin@portal.net', password: '3YP)g14*', deletable: false

#Admin.create name: 'Default Admin', email: 'admin@portal.net', password: '3YP)g14*', deletable: false
#Instructor.create name: 'Instructor1', email: 'instructor1@portal.net', password: '12345', deletable: true
#Instructor.create name: 'Instructor2', email: 'instructor2@portal.net', password: '12345', deletable: true
# Course.create coursenumber: 'CSC 501', title: 'Operating Systems', description: 'An operating system (OS) is system software that manages computer hardware and software resources and provides common services for computer programs. The operating system is a component of the system software in a computer system.', start_date:'2016-01-01', end_date:'2016-06-06', instructor_id: 2, status:true
# Course.create coursenumber: 'CSC 510', title: 'Software Engineering', description: 'Software engineering is the study and an application of engineering to the design, development and maintenance of software', start_date:'2016-01-01', end_date:'2016-06-06', instructor_id: 3, status:true
# History.create is_current: true, user_id:1, course_id:3
# History.create is_current: true, user_id:1, course_id:4