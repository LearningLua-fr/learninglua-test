local function contains_console_log(code)
    return string.match(code, "console%.log%s*%(") ~= nil
end

local function contains_direct_bonjour(code)
    return string.match(code, [["Bonjour"]]) ~= nil or string.match(code, [['Bonjour']]) ~= nil
end

local function uses_fs_module(code)
    return string.match(code, [[require%s*%(?['"]fs['"]%)?]]) ~= nil
end

local function writes_to_input_file(code)
    return code:match("fs%.writeFile") or code:match("fs%.writeFileSync")
end

local function reads_from_input_file(code)
    return code:match("fs%.readFile") or code:match("fs%.readFileSync")
end

local function final_is_equal(user_output, expected_output_user)
    local function normalize(str)
        return (str:gsub("%s+", " "):gsub("^%s*(.-)%s*$", "%1"))
    end
    return normalize(user_output) == normalize(expected_output_user)
end

function run_test(user_code, user_output, expected_output_user)
    local passed = 0
    local total = 6

    if not contains_console_log(user_code) then
        print("Test 1/6 Passed: No console.log used.")
        passed = passed + 1
    else
        print("Test 1/6 Failed: console.log is used")
    end

    if contains_direct_bonjour(user_code) then
        print("Test 2/6 Passed: 'Bonjour' string is present.")
        passed = passed + 1
    else
        print("Test 2/6 Failed: 'Bonjour' string is missing.")
    end

    if uses_fs_module(user_code) then
        print("Test 3/6 Passed: fs module is used.")
        passed = passed + 1
    else
        print("Test 3/6 Failed: fs module is not used.")
    end

    if writes_to_input_file(user_code) then
        print("Test 4/6 Passed: input.txt is written.")
        passed = passed + 1
    else
        print("Test 4/6 Failed: No writing to input.txt.")
    end

    if reads_from_input_file(user_code) then
        print("Test 5/6 Passed: input.txt is read.")
        passed = passed + 1
    else
        print("Test 5/6 Failed: input.txt is not read.")
    end

    if final_is_equal(user_output, expected_output_user) then
        print("Test 6/6 Passed: Output matches expected.")
        passed = passed + 1
    else
        print("Test 6/6 Failed: Output mismatch.")
    end

    if passed == total then
        print("All tests passed.")
    else
        print("Some tests failed.")
    end
end


-- Execution
run_test(user_code, user_output, expected_output_user)
