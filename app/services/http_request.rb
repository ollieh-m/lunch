require 'net/http'

class HttpRequest

  attr_reader :uri, :method, :data, :https, :headers

  def initialize(url:, method: :get, data: nil, https: true, headers: nil)
    @uri = URI(url)
    @method = method
    @data = data
    @https = https
    @headers = headers
  end

  def perform(parse: true)
    initialize_request
    set_data if data
    set_headers if headers

    res = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => https) do |http|
      http.request(@req)
    end

    if parse
      return parse_response(res)
    else
      return res
    end
  end

  private

  def parse_response(res)
    { status: res.code.to_i, body: JSON.parse(res.body) }
  end

  def initialize_request
    @req = Net::HTTP::Post.new(uri) if method == :post
    @req = Net::HTTP::Get.new(uri) if method == :get
  end

  def set_data
    @req.set_form_data(data)
  end

  def set_headers
    headers.each do |key, value|
      @req[key] = value
    end
  end

end
