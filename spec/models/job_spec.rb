describe Job do

  it { should belong_to :company } 
  it { should have_many :interviews }
  it { should have_many :responses }
  it { should have_one(:user).through(:company)}

  let!(:date_now) { date_now = DateTime.now }
  let!(:date_prev) { date_prev = DateTime.now - 10 }
  let!(:date_future) { date_future = DateTime.now + 10 }

  describe "scope testing" do
    it "should display the number of jobs passed into scope" do
      job = FactoryGirl.create(:job)
      job2 = FactoryGirl.create(:job)
      expect(Job.all).to eq [job,job2]
      expect(Job.recent(1)).to eq [job]
    end
  end

  describe "text styling" do
    it "should titleize all the words in the description" do
      job = FactoryGirl.create(:job)
      expect(job.description).to eq "Ruby Rails Developer"
    end
    it "should downcase and titleize the location" do
      job = FactoryGirl.create(:job)
      expect(job.location).to eq "Portland, Or"
    end
    it "should downcase the posting_url" do
      job = FactoryGirl.create(:job)
      expect(job.posting_url).to eq "http://www.code.com"
    end
  end

  describe "date criteria" do
    it "should display jobs from most recent to oldest applied for" do
      job1 = Job.create({description: "Rails Dev", application_date: "12/7/2014", 
                         location: "Bend, OR", posting_url: "www.abc.com"})
      job2 = Job.create({description: "Rails Ruby Dev", application_date: "12/5/2014", 
                         location: "Portland, OR", posting_url: "www.abc.com"})
      expect(Job.order_by).to eq [job2, job1]
    end

    it "should allow job applications to be created now or prior" do
      job = FactoryGirl.create(:job, application_date: date_prev)
      job2 = FactoryGirl.create(:job, application_date: date_now)
      expect(job.application_date).to be <= date_now
      expect(job2.application_date).to be <= date_now
    end

    it "should not allow job applications to be created in the future" do
      job = FactoryGirl.build(:job, application_date: date_future)
      expect(job.save).to eq false
    end
  end

  it "should have an open or closed status" do
    job = FactoryGirl.create(:job, status:"closed")
    expect(Job.all).to eq [job]
  end
  it "should be unique to a user" do
    user = FactoryGirl.create(:user)
    job = FactoryGirl.create(:job, user_id: user.id)
    expect(job.user_id).to eq user.id
  end

  describe "nested order" do
    it "should display nested job responses by response date descending order" do
      job = FactoryGirl.create(:job, application_date: date_prev)
      response1 = FactoryGirl.create(:response, job_id: job.id, response_date: date_now-2)
      response2 = FactoryGirl.create(:response, job_id: job.id, response_date: date_now-1)
      expect(job.responses.order_by).to eq [response2, response1]
    end
    it "should display nested job interviews by interview date descending order" do
      job = FactoryGirl.create(:job, application_date: date_prev) # 12/1
      interview1 = FactoryGirl.create(:interview, job_id: job.id, interview_date: date_now) #12/6
      interview2 = FactoryGirl.create(:interview, job_id: job.id, interview_date: date_future) #12/10
      expect(job.interviews).to eq [interview2, interview1]
    end
  end

  it "should add 'http://' to job.posting_url if missing" do
      job = FactoryGirl.create(:job, posting_url: "www.yahoo.com")
      expect(job.posting_url).to eq 'http://www.yahoo.com'
  end


end


