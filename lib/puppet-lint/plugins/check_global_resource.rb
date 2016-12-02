PuppetLint.new_check(:global_resource) do
  def check

    secure = []

    class_indexes.each { |c| secure << [c[:start], c[:end]] }
    defined_type_indexes.each { |d| secure << [d[:start], d[:end]] }
    node_indexes.each { |n| secure << [n[:start], n[:end]] }

    resource_indexes.each do |r|
      encap = 0
      secure.each do |s|
        if s[0] < r[:start] and s[1] > r[:end]
          encap = 1
        end
      end
      next if encap == 1

      notify(:error, {
        :message => "Resource #{r[:type].value} in global space",
        :line => r[:type].line,
        :column => r[:type].column,
      })
    end

    tokens.each_index do |i|
      token = tokens[i]
      next unless token.type = :NAME and token.value == 'include'

      encap= 0
      secure.each do |s|
        if s[0] < i and s[1] > i
          encap = 1
        end
      end
      next if encap == 1

      notify(:error, {
        :message => "include #{token.next_code_token.value} in global space",
        :line => token.line,
        :column => token.column,
      })
    end

  end

end
