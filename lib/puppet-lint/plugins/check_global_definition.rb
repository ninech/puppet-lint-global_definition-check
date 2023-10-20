module PuppetLintGlobalDefinionCheck
  private

  def check_for_global_token(type)
    global_tokens.each do |token|
      next unless token.type == type

      message = yield(token)
      next unless message

      notify :error,
        message: "#{message} in global space",
        line: token.line,
        column: token.column
    end
  end

  def global_tokens
    @global_tokens ||= tokens.reject.with_index { |_, i| secure_ranges.any? { |s| s[0] < i && s[1] > i } }
  end

  def secure_ranges
    return @secure_ranges if @secure_ranges

    @secure_ranges = []

    class_indexes.each { |c| @secure_ranges << [c[:start], c[:end]] }
    defined_type_indexes.each { |d| @secure_ranges << [d[:start], d[:end]] }
    node_indexes.each { |n| @secure_ranges << [n[:start], n[:end]] }

    @secure_ranges
  end
end

PuppetLint.new_check(:global_resource) do
  include PuppetLintGlobalDefinionCheck

  def check
    check_for_global_resources
    check_for_global_token(:NAME) do |token|
      "#{token.value} #{token.next_code_token.value}" if token.value == "include"
    end
  end

  def check_for_global_resources
    resource_indexes.each do |r|
      next if secure_ranges.any? { |s| s[0] < r[:start] && s[1] > r[:end] }

      notify :error,
        message: "resource #{r[:type].value} in global space",
        line: r[:type].line,
        column: r[:type].column
    end
  end
end

PuppetLint.new_check(:global_function) do
  include PuppetLintGlobalDefinionCheck

  def check
    check_for_global_token(:FUNCTION_NAME) do |token|
      "function call #{token.value}(...)" unless !token.prev_code_token.nil? && token.prev_code_token.type == :FUNCTION
    end
  end
end
