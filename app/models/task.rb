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

  attr_accessor :created_at_start, :created_at_end

  belongs_to :user

  validates_inclusion_of :status, in: %w(Task::Status::Open Task::Status::Close Task::Status::Wip)

  scope :filter_by_title, -> (title) { where("lower(title) = ?", title.downcase) }
  scope :filter_by_status, -> (status) { where(status: status) }
  scope :filter_by_created_at, -> (_beg, _end) { where(created_at: (_beg.beginning_of_day)..(_end.end_of_day)) }
end
