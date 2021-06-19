FactoryBot.define do
  factory :task do
    title   { FFaker::Product.product_name }
    status  { %w(Task::Status::Open Task::Status::Close Task::Status::Wip).sample }
    user
  end
end
