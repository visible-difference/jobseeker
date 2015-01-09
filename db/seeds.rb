# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user1 = User.create(email: "randyleighton@yahoo.com", username:"Randy", password: "test1234")

company1 = Company.create(name: "Coding Academy", url:"www.code.com", comments:"coding company", user_id: user1.id)
company2 = Company.create(name: "Dogma Coders", url: "www.dogma.com", comments:"only the best", user_id: user1.id)
job1 = Job.create(description: "Ruby Rails Developer", location: "Portland, OR", company_id: company2.id,
                  posting_url: "http:/www.indeed.com", application_date: DateTime.now-5, user_id: user1.id)
contact1 = Contact.create(first_name: "George", last_name: "Georgeson", title: "Recruiter", 
                          email:"George@#{company1.name}.com", notes:"this is the one who hires people", 
                          company_id: company1.id, user_id: user1.id)
response1 = Response.create(notes: "We want to interview you", response_date: DateTime.now-1, job_id: job1.id,
                            user_id: user1.id, contact_id: contact1.id)
interview1 = Interview.create(interview_date: DateTime.now+5, notes: "Interview with the VP", 
                               interview_time: "12:00 PM", job_id: job1.id, user_id: user1.id)

