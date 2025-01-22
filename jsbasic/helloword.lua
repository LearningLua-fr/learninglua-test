

local function contains_console_log(code)
    -- Pattern to match 'console.log(' with optional whitespace
    return string.match(code, "console%.log%s*%(") ~= nil
end


local function normalize_string(str)
    -- Replace one or more whitespace characters with a single space
    local normalized = string.gsub(str, "%s+", " ")
    -- Trim leading and trailing whitespaces
    normalized = string.gsub(normalized, "^%s*(.-)%s*$", "%1")
    return normalized
end

local function final_is_equal(user_output, expected_output_user)
    local normalized_user_output = normalize_string(user_output)
    local normalized_expected_output = normalize_string(expected_output_user)
    return normalized_user_output == normalized_expected_output
end

-- Function to run the unit tests
local function run_test(user_code, user_output, expected_output_user)
    -- Test 1: Check if output matches expected output
    if final_is_equal(user_output, expected_output_user) then
        print("Test Passed 1/2: Output matches expected output.")
    else
        print("Test Failed 1/2: Output does not match expected output.")
    end

    -- Test 2: Check if code contains a console.log statement
    if contains_console_log(user_code) then
        print("Test Passed 2/2: console.log statement found in the code.")
    else
        print("Test Failed 2/2: No console.log statement found in the code.")
    end

    -- Final Summary
    if final_is_equal(user_output, expected_output_user) and contains_console_log(user_code) then
        print("All tests passed.")
    else
        print("Some tests failed. Please review your code and output.")
    end
end

run_test(user_code, user_output, expected_output_user)
