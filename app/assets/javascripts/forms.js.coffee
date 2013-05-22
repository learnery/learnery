jQuery ->
  # rails set's the error-class on input fields
  # but bootstrap needs the error-class on the control-group that wraps the input field
  $("input.error").parents('.control-group').addClass('error')
