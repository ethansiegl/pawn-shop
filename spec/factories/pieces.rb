FactoryGirl.define do
  factory :piece do
  	association :game
  	x_coordinate 0
  	y_coordinate 0
  end
end