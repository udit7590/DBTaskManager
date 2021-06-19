class Task < ApplicationRecord
  module Status
    module Open
      def self.key
        'Open'
      end
    end

    module Wip
      def self.key
        'Work in Progress'
      end
    end

    module Close
      def self.key
        'Closed'
      end
    end
  end

  belongs_to :user

  validates_inclusion_of :status, in: %w(Task::Status::Open Task::Status::Close Task::Status::Wip)
end
