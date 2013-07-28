function show_subform(){
     var v = $('body.edit.events #event_type, body.new.events #event_type').val();
     if(!v) return;
     var c = v.substr(1+v.lastIndexOf(":"));
     $('.subform').hide();
     $('.subform.' + c ).show();
}


$(document).ready(function(){
  $('body.edit.events #event_type, body.new.events #event_type').on('change', show_subform );
  show_subform();
});



