class JobPostingsController < ApplicationController
  before_action :set_job_posting, except: [:index, :new, :create]

  def index
    @job_postings = JobPosting.all
  end

  def show
  end

  def new
    @job_posting = JobPosting.new
  end

  def edit
  end

  def create
    @job_posting = JobPosting.new(job_posting_params)

    respond_to do |format|
      if @job_posting.save
        format.html { redirect_to @job_posting, notice: 'Job posting was successfully created.' }
        format.json { render :show, status: :created, location: @job_posting }
      else
        format.html { render :new }
        format.json { render json: @job_posting.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @job_posting.update(job_posting_params)
        format.html { redirect_to @job_posting, notice: 'Job posting was successfully updated.' }
        format.json { render :show, status: :ok, location: @job_posting }
      else
        format.html { render :edit }
        format.json { render json: @job_posting.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @job_posting.destroy
    respond_to do |format|
      format.html { redirect_to job_postings_url, notice: 'Job posting was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_job_posting
      @job_posting = JobPosting.find(params[:id])
    end

    def job_posting_params
      params.require(:job_posting).permit(
        :city,
        :country_code,
        :description,
        :end_date,
        :job_type,
        :province_code,
        :remote,
        :start_date,
        :title,
        :url,
      )
    end
end
