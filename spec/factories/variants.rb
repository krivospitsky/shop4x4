# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :variant do
    product_id 1
    option_value "MyString"
    sku "MyString"
    price 1
    count 1
    enabled false
  end
end
