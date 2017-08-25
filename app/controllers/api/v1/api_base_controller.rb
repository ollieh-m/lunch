class Api::V1::ApiBaseController < ApplicationController
  protect_from_forgery with: :null_session
end
