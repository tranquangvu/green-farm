class ApiResponse
  attr_accessor :status, :data
  STATUSES = [:success, :failed]
  def initialize(status: nil, data: {})
    @status, @data = status, data
  end
  def set(options = {})
    options.each do |key, value|
      send("#{key}=", value)
    end
    self
  end
  STATUSES.each do |status|
    define_method(status) do |data = {}|
      set(status: status, data: data)
    end
  end
end
