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
    @global_tokens ||= tokens.reject.with_index { |_, i| safe_ranges.any? { |s| s[0] < i && s[1] > i } }
  end

  def custom_functions_indexes
    # Code adapted from https://github.com/puppetlabs/puppet-lint/blob/dcff4a1b8d3bf5c15762db826967dd03200626be/lib/puppet-lint/data.rb#L298
    type = :FUNCTION
    result = []
    tokens.each_with_index do |token, i|
      next unless token.type == type

      brace_depth = 0
      paren_depth = 0
      in_params = false
      return_type = nil
      tokens[i + 1..-1].each_with_index do |definition_token, j|
        case definition_token.type
        when :LPAREN
          in_params = true if paren_depth.zero? && brace_depth.zero?
          paren_depth += 1
        when :RPAREN
          in_params = false if paren_depth == 1 && brace_depth.zero?
          paren_depth -= 1
        when :RSHIFT
          return_type = definition_token.next_code_token unless definition_token.next_code_token.nil? || definition_token.next_code_token.type != :TYPE
        when :LBRACE
          brace_depth += 1
        when :RBRACE
          brace_depth -= 1
          if brace_depth.zero? && !in_params && (token.next_code_token.type != :LBRACE)
            result << {
              start: i,
              end: i + j + 1,
              tokens: tokens[i..(i + j + 1)],
              param_tokens: PuppetLint::Data.param_tokens(tokens[i..(i + j + 1)]),
              type: type,
              name_token: token.next_code_token,
              return_type: return_type
            }
            break
          end
        end
      end
    end
    result
  end

  def safe_ranges
    return @safe_ranges if @safe_ranges

    @safe_ranges = []

    class_indexes.each { |c| @safe_ranges << [c[:start], c[:end]] }
    defined_type_indexes.each { |d| @safe_ranges << [d[:start], d[:end]] }
    node_indexes.each { |n| @safe_ranges << [n[:start], n[:end]] }
    custom_functions_indexes.each { |cf| @safe_ranges << [cf[:start], cf[:end]] }

    @safe_ranges
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
      next if safe_ranges.any? { |s| s[0] < r[:start] && s[1] > r[:end] }

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
      "function call #{token.value}(...)"
    end
  end
end
