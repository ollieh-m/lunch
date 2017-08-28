class Api::V1::MessageActionsController < Api::V1::ApiBaseController

  def create
    # quickly check that a choice was submitted - if so
    MessageReceivedJob.perform_later(JSON.parse(params[:payload]))
    render json: "That's great, thanks", status: 200
    # if not, rerender the message with some extra text
  end

end
