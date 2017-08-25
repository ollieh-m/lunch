class Api::V1::BantaclausesController < Api::V1::ApiBaseController

  def create
    Bantaclauses::Create.new(params).perform
  end

end
