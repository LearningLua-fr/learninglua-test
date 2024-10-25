function contains_function_declaration(code)
    return string.match(code, "function%s+IterateFruits%s*%(%s*%)") ~= nil
end


function contains_ipairs_loop(code)
    return string.match(code, "for%s+[%w_]+,%s*[%w_]+%s+in%s+ipairs") ~= nil
end


function capture_user_output(user_function)
    local output = {}
    local original_print = print
    print = function(str) table.insert(output, str) end
    user_function() 
    print = original_print  
    return table.concat(output, "\n")
end

function run_test(user_code, user_function, expected_output_user)
    if contains_function_declaration(user_code) then
        print("Test Passed 1/3: Function 'IterateFruits' is correctly defined")
    else
        print("Test Failed 1/3: Function 'IterateFruits' is missing or incorrect")
    end

    if contains_ipairs_loop(user_code) then
        print("Test Passed 2/3: Loop with 'ipairs' is correctly defined")
    else
        print("Test Failed 2/3: Loop with 'ipairs' is missing or incorrect")
    end

    local user_output = capture_user_output(user_function)
    if user_output == expected_output_user then
        print("Test Passed 3/3: Function works correctly and outputs expected results")
    else
        print(string.format("Test Failed 3/3: Expected output '%s', but got '%s'", expected_output_user, user_output))
    end

    if contains_function_declaration(user_code) and contains_ipairs_loop(user_code) and user_output == expected_output_user then
        print("All tests passed")
    else
        print("Some tests failed")
    end
end

run_test(user_code, IterateFruits, expected_output_user)
