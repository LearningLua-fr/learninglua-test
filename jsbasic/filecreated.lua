local function contains_forbidden_output(code)
    local forbidden_patterns = {
        'print%s*%(%s*["\']Bonjour["\']%s*%)',
        'console%.log%s*%(%s*["\']Bonjour["\']%s*%)',
        '["\']Bonjour["\']'
    }

    for _, pattern in ipairs(forbidden_patterns) do
        if string.match(code, pattern) then
            return true
        end
    end

    return false
end

local function normalize_string(str)
    return string.gsub(str or "", "%s+", " "):gsub("^%s*(.-)%s*$", "%1")
end

local function file_exists(filename)
    local f = io.open(filename, "r")
    if f then f:close() return true else return false end
end

local function read_file(filename)
    local f = io.open(filename, "r")
    if not f then return nil end
    local content = f:read("*all")
    f:close()
    return content
end

local function run_test(user_code, user_output, expected_output_user)
    local passed = true

    -- 1. Check for forbidden direct usage
    if contains_forbidden_output(user_code) then
        print("Test 1/5 Failed: Direct usage of 'Bonjour' found in code.")
        passed = false
    else
        print("Test 1/5 Passed: No direct usage of 'Bonjour'.")
    end

    -- 2. Check if file exists
    if file_exists("input.txt") then
        print("Test 2/5 Passed: 'input.txt' exists.")
    else
        print("Test 2/5 Failed: 'input.txt' is missing.")
        passed = false
    end

    -- 3. Check file content
    local file_content = read_file("input.txt")
    if normalize_string(file_content) == "Bonjour" then
        print("Test 3/5 Passed: File content is correct.")
    else
        print("Test 3/5 Failed: File content is incorrect.")
        passed = false
    end

    -- 4. Check user output
    if normalize_string(user_output) == "Bonjour" then
        print("Test 4/5 Passed: Output is correct.")
    else
        print("Test 4/5 Failed: Output does not match.")
        passed = false
    end

    -- 5. Compare with expected output
    if normalize_string(user_output) == normalize_string(expected_output_user) then
        print("Test 5/5 Passed: Output matches expected result.")
    else
        print("Test 5/5 Failed: Output does not match expected result.")
        passed = false
    end

    if passed then
        print("All tests passed.")
    else
        print("Some tests failed.")
    end
end

-- Execute the test
run_test(user_code, user_output, expected_output_user)
