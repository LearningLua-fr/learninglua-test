local function contains_console_log(code)
    return string.match(code, "console%.log%s*%(") ~= nil
end

local function contains_direct_bonjour(code)
    return string.match(code, [["Bonjour"]]) ~= nil or string.match(code, [['Bonjour']]) ~= nil
end

local function uses_fs_module(code)
    return string.match(code, [[require%s*%(?['"]fs['"]%)?]]) ~= nil
end

local function checks_input_file(code)
    return string.match(code, "input%.txt") ~= nil and string.match(code, "fs%.writeFileSync") ~= nil
end

local function reads_input_file(code)
    return string.match(code, "fs%.readFileSync") ~= nil
end

local function final_is_equal(user_output, expected_output_user)
    local function normalize(str)
        return (str:gsub("%s+", " "):gsub("^%s*(.-)%s*$", "%1"))
    end
    return normalize(user_output) == normalize(expected_output_user)
end

local function run_test(user_code, user_output, expected_output_user)
    local ok = true

    if contains_console_log(user_code) then
        print("Test 1/6 Failed: console.log is used")
        ok = false
    else
        print("Test 1/6 Passed: No console.log used.")
    end

    if contains_direct_bonjour(user_code) then
        print("Test 2/6 Passed: Bonjour is written to file only.")
    else
        print("Test 2/6 Failed: No 'Bonjour' string found.")
        ok = false
    end

    if uses_fs_module(user_code) then
        print("Test 3/6 Passed: fs module required.")
    else
        print("Test 3/6 Failed: fs module not used.")
        ok = false
    end

    if checks_input_file(user_code) then
        print("Test 4/6 Passed: input.txt creation checked.")
    else
        print("Test 4/6 Failed: input.txt check missing.")
        ok = false
    end

    if reads_input_file(user_code) then
        print("Test 5/6 Passed: input.txt is read.")
    else
        print("Test 5/6 Failed: input.txt is not read.")
        ok = false
    end

    if final_is_equal(user_output, expected_output_user) then
        print("Test 6/6 Passed: Output is correct.")
    else
        print("Test 6/6 Failed: Output mismatch.")
        ok = false
    end

    if ok then
        print("All tests passed.")
    else
        print("Some tests failed.")
    end
end

-- Execution
run_test(user_code, user_output, expected_output_user)
