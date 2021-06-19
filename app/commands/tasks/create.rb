module Tasks
  class Create < BaseCommand

    def initialize(task, *)
      @model            = task
    end

    def run
      context[:position] = current_position
      success!
    end

    def valid?
      super { robot_placed? }
    end

    def robot_placed?
      unless model.placed?
        errors[:cmd] ||= []
        errors[:cmd] << 'Robot is not yet placed on the area'
      end
    end
  end
end
