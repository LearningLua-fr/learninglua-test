local function contains_console_log(code)
    return string.match(code, "console%.log%s*%(") ~= nil
end

local function defines_print_function(code)
    return string.match(code, "function%s+printString%s*%(") ~= nil
end

local function uses_process_stdout(code)
    return string.match(code, "process%.stdout%.write%s*%(") ~= nil
end

local function includes_write_file(code)
    return string.match(code, "fs%.writeFileSync%s*%(") ~= nil
end

local function includes_read_file(code)
    return string.match(code, "fs%.readFileSync%s*%(") ~= nil or string.match(code, "fs%.readFile%s*%(") ~= nil
end

local function expected_output_string()
    local str = ""
    for i = 1, 1000 do
        str = str .. i
        if i < 1000 then
            str = str .. ","
        end
    end
    return str
end

local function run_test(user_code, user_output, expected_output_user)
    local passed = true
    local expected = expected_output_string()

    if contains_console_log(user_code) then
        print("Test 1/6 Failed: console.log is forbidden.")
        passed = false
    else
        print("Test 1/6 Passed: No console.log used.")
    end

    if defines_print_function(user_code) and uses_process_stdout(user_code) then
        print("Test 2/6 Passed: printString is valid.")
    else
        print("Test 2/6 Failed: printString invalid.")
        passed = false
    end

    if includes_write_file(user_code) then
        print("Test 3/6 Passed: fs.writeFileSync used.")
    else
        print("Test 3/6 Failed: Missing write to file.")
        passed = false
    end

    if includes_read_file(user_code) then
        print("Test 4/6 Passed: fs.readFile or fs.readFileSync used.")
    else
        print("Test 4/6 Failed: Missing read from file.")
        passed = false
    end

    if user_output == expected then
        print("Test 5/6 Passed: Output matches expected.")
    else
        print("Test 5/6 Failed: Output does not match.")
        passed = false
    end

    if passed then
        print("Test 6/6 Passed: All checks passed.")
    else
        print("Test 6/6 Failed: Some checks failed.")
    end
end

-- Execution
run_test(user_code, user_output, expected_output_user)
