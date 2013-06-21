# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :location do
    field_id 1
    x_cordinate 1
    y_cordinate 1
    state "MyString"
  end
end
