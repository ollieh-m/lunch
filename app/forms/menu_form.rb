class MenuForm < Reform::Form

  include Reform::Form::ActiveModel::ModelReflections
  feature Reform::Form::MultiParameterAttributes

  OptionPopulator = -> (collection:, index:, fragment:, **) {
    # called on each option from input
    # check if the input option is an existing option in menu.options
    if fragment[:id].to_s ==  ""
      item=nil
    else
      item = collection.find { |item| item.id.to_s == fragment[:id].to_s }
    end
    # if it is and the input says destroy, remove the option from the input graph so the collection will be saved without it
    if fragment["_destroy"] == "1"
      collection.delete(item) if item
      return skip!
    else
    # if the input option does not have an existing corresponding form (because it was not an existing option within menu.options)
    # then now add to the collection a new option around which a form will wrap - the same as populate_in_empty
      item ? item : collection.append(Option.new)
    end
  }

  property :date, :multi_params => true

  collection :options, populator: OptionPopulator, prepopulator: ->(options) { self.options << Option.new } do
    include NestedForm

    property :meal, populate_if_empty: Meal, prepopulator: ->(options) { self.meal = Meal.new } do
      property :name
      property :description
    end
  end

end
