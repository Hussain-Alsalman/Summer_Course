library("rlang")

check_ex1 <- function(label,
                      user_code,
                      solution_code,
                      check_code,
                      envir_result,
                      evaluate_result,
                      envir_prep,
                      ...) {
  correct_answer = FALSE
  code <- parse_quo(user_code, envir_result)
    if (quo_is_call(code)) {
      if (length(call_args(code)) > 0) {
        if (call_name(code) == "+" || call_name(code) == "sum") {
          feedback <- "Great Job, you succesfully"
          correct_answer = TRUE
        } else{
          feedback <-
            "remember you can use 'sum' or '+' to perform summation"
        }
      } else{
        feedback <-
          "The function you specified does not have any arguments"
      }
    } else{
      feedback <- "I don't see any operation or function in your code"
    }
    
    return(list(
      message = feedback,
      correct = correct_answer,
      location = "append"
    ))
  
}

