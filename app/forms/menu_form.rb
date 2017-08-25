class MenuForm < Reform::Form

  feature Reform::Form::MultiParameterAttributes

  property :date, :multi_params => true

  collection :options, populate_if_empty: Option, prepopulator: ->(options) { self.options = [Option.new, Option.new] } do
    property :meal, populate_if_empty: Meal, prepopulator: ->(options) { self.meal = Meal.new } do
      property :name
      property :description
    end
  end

end
