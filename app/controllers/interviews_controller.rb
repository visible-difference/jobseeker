class InterviewsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_interview, except: [:index,:new, :create]
  before_filter :find_job, only: [:new, :create, :show]
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def index
    @all_interviews = Interview.all
  end

  def new
    @interview = Interview.new
  end

  def create
    @interview = Interview.create(interview_params)
    if @interview.valid?
      redirect_to job_interview_path, notice: "Interview on #{@interview.interview_date} created."
    else
      render 'new', alert: "Interview could not be created."
    end
  end

  def show
    @company = Company.find(@job.company_id)
  end

  def update
    if @interview.update_attributes(interview_params)
      redirect_to job_interview_path, notice: "#Interview updated."
    else
      render job_interview_path(@interview), alert: "Failed to Update."
    end
  end

  def destroy
    @interview.destroy
    flash[:notice]="Interview deleted"
    redirect_to interviews_path
  end

  private

  def find_interview
    @interview = Interview.find(params[:id])
  end

  def find_job
    @job = Job.find(params[:job_id])
  end

  def interview_params
    params.require(:interview).permit(:interview_date, :notes, :job_id)
  end

  def not_found
      session[:return_to]||= root_url
      redirect_to session[:return_to], flash: {alert: 'Problem finding record, you might not be authorized.'}
  end

end