-- Check if the user code defines the function 'IterateFruits'
function contains_function_declaration(code)
    return code and string.match(code, "function%s+IterateFruits%s*%(%s*%)") ~= nil
end

-- Check if the user code includes a for loop with 'ipairs' to iterate over the array
function contains_ipairs_loop(code)
    return code and string.match(code, "for%s+[%w_]+,%s*[%w_]+%s+in%s+ipairs") ~= nil
end

-- Executes the user function and captures output
function capture_user_output(user_function)
    local output = {}
    local original_print = print
    print = function(str) table.insert(output, str) end
    if user_function then user_function() end  -- Run the user's function if it exists
    print = original_print  -- Restore original print
    return table.concat(output, "\n")
end

-- Main test function
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
        print(string.format("Test Failed 3/3: Expected output '%s', but got '%s'", expected_output_user or "nil", user_output or "nil"))
    end

    if contains_function_declaration(user_code) and contains_ipairs_loop(user_code) and user_output == expected_output_user then
        print("All tests passed")
    else
        print("Some tests failed")
    end
end

-- Example of how to use the test
-- Assuming user_code is the string of code written by the user, and IterateFruits is their function.
-- run_test(user_code, IterateFruits, expected_output_user)
