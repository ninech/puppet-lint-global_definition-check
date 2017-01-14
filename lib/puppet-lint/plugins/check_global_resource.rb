PuppetLint.new_check(:global_resource) do
  def check
    @secure = secure_ranges

    check_for_global_resources
    check_for_global_includes
  end

  def secure_ranges
    secure = []

    class_indexes.each { |c| secure << [c[:start], c[:end]] }
    defined_type_indexes.each { |d| secure << [d[:start], d[:end]] }
    node_indexes.each { |n| secure << [n[:start], n[:end]] }

    secure
  end

  def check_for_global_resources
    resource_indexes.each do |r|
      next if @secure.any? { |s| s[0] < r[:start] && s[1] > r[:end] }

      notify :error,
             message: "Resource #{r[:type].value} in global space",
             line: r[:type].line,
             column: r[:type].column
    end
  end

  def check_for_global_includes
    tokens.each_index do |i|
      token = tokens[i]
      next unless token.type == :NAME && token.value == 'include'

      next if @secure.any? { |s| s[0] < i && s[1] > i }

      notify :error,
             message: "include #{token.next_code_token.value} in global space",
             line: token.line,
             column: token.column
    end
  end
end
