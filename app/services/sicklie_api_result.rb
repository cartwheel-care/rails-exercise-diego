class SicklieApiResult
  HASH_PROCESS = -> (result) { "#{result[:status_code]}: #{result[:field]} #{result[:message]}" }

  attr_reader :error_message

  def initialize(result)
    @result = result
    @success, @error_message = process_result
  end

  def success?
    @success
  end

  def body
    @result
  end

  private

  def process_result
    case @result.class.to_s
    when 'Array'
      [false, @result.map{ |res| HASH_PROCESS.call(res) }.join('. ')]
    when 'Hash'
      if @result[:status_code] == "SUCCESS"
        [true, nil]
      else
        [false, HASH_PROCESS.call(@result)]
      end
    else
      [false, @result]
    end
  end
end
