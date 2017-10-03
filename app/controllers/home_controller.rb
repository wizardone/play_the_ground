class HomeController < ApplicationController

  before_action :rate_limit

  def index
    render plain: "I am Index"
  end

  private

  def rate_limit
    limit = Raterr.enforce(request, period: :hour, max: 10)
    if limit[:status] == 429
      render plain: limit[:text], status: limit[:status] and return
    end
  end
end
