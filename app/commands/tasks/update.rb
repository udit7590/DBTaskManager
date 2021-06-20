module Tasks
  class Update < BaseCommand
    attr_accessor :params

    def initialize(task, params:)
      @model  = task
      @params = params
    end

    def run
      @model.update(params) ? success! : fail!
    end
  end
end
