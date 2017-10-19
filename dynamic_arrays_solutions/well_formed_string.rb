def well_formed?(str)
    paired_chars = {
        "[" => "]",
        "{" => "}",
        "(" => ")"
    }

    left_chars_stack = []

    str.chars.each do |ch|
        if paired_chars.keys.include?(ch)
            left_chars_stack.push(ch)
        elsif paired_chars[left_chars_stack.last]
            left_chars_stack.pop
        end
             
    end

    left_chars_stack.empty?
end
