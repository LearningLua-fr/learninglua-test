function contains_function(code)
    return code:match("function%s+countWords")
end

function contains_call(code)
    return code:match('countWords%s*%(%s*"hello%s+hello%s+world"%s*%)')
end

function output_is_correct(output)
    return output:gsub("\r", ""):match("^%s*hello:2%s+world:1%s*$") ~= nil
end

function run_test(user_code, user_output, expected_output_user)
    local passed = 0

    if contains_function(user_code) then
        print("Test 1/4 Passed: Function 'countWords' is defined")
        passed = passed + 1
    else
        print("Test 1/4 Failed: Function is missing")
    end

    if contains_call(user_code) then
        print("Test 2/4 Passed: Function is called with 'hello hello world'")
        passed = passed + 1
    else
        print("Test 2/4 Failed: Function call is missing")
    end

    if not user_code:match("console%.log") and not user_code:match("hello:2%s+world:1") then
        print("Test 3/4 Passed: Output is not hardcoded and console.log is not used")
        passed = passed + 1
    else
        print("Test 3/4 Failed: Output is hardcoded or console.log used")
    end

    if output_is_correct(user_output) then
        print("Test 4/4 Passed: Output is correct")
        passed = passed + 1
    else
        print("Test 4/4 Failed: Output is incorrect")
    end

    if passed == 4 then
        print("All tests passed")
    else
        print("Some tests failed")
    end
end

run_test(user_code, user_output, expected_output_user)