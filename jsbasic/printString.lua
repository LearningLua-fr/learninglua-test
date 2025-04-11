local function contains_print_function(code)
    return string.match(code, "function%s+printString%s*%(") ~= nil
end

local function calls_print_function(code)
    return string.match(code, "printString%s*%(%s*%)") ~= nil
end

local function contains_console_log(code)
    return string.match(code, "console%.log") ~= nil
end

local function final_output_is_correct(user_output, expected_output)
    local clean = function(s)
        return string.gsub(s, "%s+", " "):gsub("^%s*(.-)%s*$", "%1")
    end
    return clean(user_output) == clean(expected_output)
end

-- Test runner
local function run_test(user_code, user_output, expected_output_user)
    local passed = true

    if contains_console_log(user_code) then
        print("❌ Test 1/4 Failed: You used console.log, which is forbidden.")
        passed = false
    else
        print("✅ Test 1/4 Passed: console.log is not used.")
    end

    if contains_print_function(user_code) then
        print("✅ Test 2/4 Passed: printString function is defined.")
    else
        print("❌ Test 2/4 Failed: printString function is not defined.")
        passed = false
    end

    if calls_print_function(user_code) then
        print("✅ Test 3/4 Passed: printString is called.")
    else
        print("❌ Test 3/4 Failed: printString is not called.")
        passed = false
    end

    if final_output_is_correct(user_output, expected_output_user) then
        print("✅ Test 4/4 Passed: Output is as expected.")
    else
        print("❌ Test 4/4 Failed: Output is incorrect.")
        passed = false
    end

    if passed then
        print("🎉 All tests passed. Well done!")
    else
        print("⚠️ Some tests failed. Please review your code.")
    end
end

-- Exemple d’appel
run_test(user_code, user_output, expected_output_user) 
