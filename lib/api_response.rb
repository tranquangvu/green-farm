class ApiResponse
  attr_accessor :success, :data

  def initialize(success: nil, data: {})
    @success, @data = success, data
  end

  def set(options = {})
    options.each do |key, value|
      send("#{key}=", value)
    end
    self
  end

  def success(data={})
    set(success: true, data: data)
  end

  def failure(data={})
    set(success: false, data: data)
  end
end
