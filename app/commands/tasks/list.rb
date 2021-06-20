module Tasks
  class List < BaseCommand
    attr_accessor :user, :params

    # Filters Eg. ?filters[status]=Task::Status::Open&filters[title]=Abc&filters[created_at][beg]=20-06-2021&filters[created_at][end]=21-06-2021
    def initialize(params:, user:)
      @user     = user
      @params   = params
      @model    = user.tasks
    end

    def run
      filter_records
      success!
    end

    private

    def filter_records
      if params[:status].present?
        @model = @model.filter_by_status(params[:status])
      end

      if params[:title].present?
        @model = @model.filter_by_title(params[:title])
      end

      if params[:created_at_start].present?
        start_date  = Date.strptime(params[:created_at_start], "%m-%d-%Y")
        end_date    = Date.strptime((params[:created_at_end].presence || params[:created_at_start]), "%m-%d-%Y")
        @model      = @model.filter_by_created_at(start_date, end_date)
      end
    end
  end
end
