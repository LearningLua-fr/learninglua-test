function run_test(user_code, user_output, expected_output)
    if user_output == expected_output then
        print("Test Passed!")
    else
        print("Test Failed!")
        print("User Code: \n" .. user_code)
        print("Expected Output: " .. expected_output)
        print("User Output: " .. user_output)
    end
end

function execute_user_code(user_code)
    return "Résultat du code utilisateur"
end


local user_code = [[
    print("Hello, World!")  -- Le code soumis par l'utilisateur
]]

local expected_output = "Hello, World!" 
local user_output = execute_user_code(user_code) 

run_test(user_code, user_output, expected_output)
