-- Vérifie que la fonction `ExtractLicense` est définie
function contains_function_declaration(code)
    return string.match(code, "function%s+ExtractLicense%s*%(%s*licenseStr%s*%)") ~= nil
end

-- Vérifie que le code de l'utilisateur contient une manipulation de chaîne (string.gsub ou string.sub)
function contains_string_manipulation(code)
    return string.match(code, "string%.gsub") ~= nil or string.match(code, "string%.sub") ~= nil
end

function CheckOutput(user_output, expected_output)
    if user_output == expected_output then
        return true
    else 
        return false
    end
end

-- Fonction principale de test
function run_test(user_code)
    if not contains_function_declaration(user_code) then
        print("Test Failed 1/3: The function `ExtractLicense` is not defined")
    else
        print("Test Passed 1/3")
    end
    if not contains_string_manipulation(user_code) then
        print("Test Failed 2/3: The function `ExtractLicense` does not contain any string manipulation")
    else
        print("Test Passed 2/3")
    end
    if not CheckOutput(ExtractLicense("MIT License"), "MIT") then
        print("Test Failed 3/3: The function `ExtractLicense` does not return the expected output")
    else
        print("Test Passed 3/3")
    end
    if contains_function_declaration(user_code) and contains_string_manipulation(user_code) and CheckOutput(user_ouput, expected_output) then
        print("All tests passed")
    end
end
   
run_test(user_code, user_output, expected_output_user)
